---
title: Authentication
description: Comparison between different auth methods
---

## Cookie-Based Auth vs Token-Based Auth (JWT)

### 1. Storage and Transmission

| Aspect            | Cookie-Based Auth                                                                                             | Token-Based Auth (JWT)                                                 |
| ----------------- | ------------------------------------------------------------------------------------------------------------- | ---------------------------------------------------------------------- |
| **Storage**       | Cookies are automatically managed by the browser.                                                             | Stored in `localStorage`, `sessionStorage`, or memory.                 |
| **Transmission**  | Sent automatically by the browser with every request to the domain of the cookie.                             | Sent manually in headers (e.g., `Authorization: Bearer <token>`).      |
| **CORS Handling** | Cookies require special handling for cross-origin requests (e.g., `credentials: 'include'`, `SameSite=None`). | JWTs are just data in headers and don't require special CORS handling. |

---

### 2. Cross-Origin Compatibility

| Aspect            | Cookie-Based Auth                                                            | Token-Based Auth (JWT)                                                            |
| ----------------- | ---------------------------------------------------------------------------- | --------------------------------------------------------------------------------- |
| **Cross-Origin**  | Requires setting `SameSite=None` and enabling `Secure` for cross-origin.     | JWTs are sent explicitly in headers, so cross-origin issues are easier to manage. |
| **Backend Setup** | Requires enabling `Access-Control-Allow-Credentials` and careful CORS setup. | Only needs standard CORS configuration (e.g., allowing headers).                  |

---

### 3. Security

| Aspect              | Cookie-Based Auth                                                                                   | Token-Based Auth (JWT)                                                                                                                       |
| ------------------- | --------------------------------------------------------------------------------------------------- | -------------------------------------------------------------------------------------------------------------------------------------------- |
| **CSRF Protection** | Vulnerable to CSRF if cookies are used directly. Requires CSRF tokens or `SameSite` for mitigation. | Less vulnerable, as tokens are not automatically sent by the browser. However, requires guarding against XSS.                                |
| **XSS Protection**  | Secure cookies (`HttpOnly`) prevent access via JavaScript.                                          | If stored in `localStorage` or `sessionStorage`, tokens can be accessed by malicious scripts in case of XSS. Storing in memory reduces risk. |
| **Expiration**      | Cookies can be set to expire automatically.                                                         | JWTs include an `exp` claim for expiration, but frontend must manually handle logout/refresh.                                                |

---

### 4. Ease of Use

| Aspect                 | Cookie-Based Auth                                    | Token-Based Auth (JWT)                                  |
| ---------------------- | ---------------------------------------------------- | ------------------------------------------------------- |
| **Setup Complexity**   | Requires setting cookies securely and managing CORS. | Easier to set up since JWTs are just sent in headers.   |
| **Automatic Handling** | Cookies are managed automatically by the browser.    | Frontend must explicitly send tokens with each request. |

---

### 5. Scalability

| Aspect                  | Cookie-Based Auth                                                        | Token-Based Auth (JWT)                                                              |
| ----------------------- | ------------------------------------------------------------------------ | ----------------------------------------------------------------------------------- |
| **Session Management**  | Stateful on the server (session store or database to track sessions).    | Stateless; no server storage needed for token validation (use public/private keys). |
| **Distributed Systems** | Managing session data across multiple servers or regions can be complex. | JWTs are self-contained and work seamlessly across distributed systems.             |

---

### 6. Refresh and Logout

| Aspect                 | Cookie-Based Auth                                     | Token-Based Auth (JWT)                                                                      |
| ---------------------- | ----------------------------------------------------- | ------------------------------------------------------------------------------------------- |
| **Session Expiration** | Managed by the server (e.g., cookie expiry).          | Managed by token expiration (`exp` claim). Requires refresh tokens for long-lived sessions. |
| **Logout**             | Clearing cookies invalidates the session immediately. | Logout requires invalidating tokens (e.g., on the server or blacklisting).                  |

---

### 7. Use Cases

| Use Case           | Cookie-Based Auth                                                                  | Token-Based Auth (JWT)                                                |
| ------------------ | ---------------------------------------------------------------------------------- | --------------------------------------------------------------------- |
| **Best For**       | Applications where backend and frontend are tightly coupled or on the same domain. | Applications with distributed systems, microservices, or mobile apps. |
| **Cross-Platform** | Limited to web-based apps due to cookie reliance.                                  | Ideal for web, mobile, and other API clients.                         |

---

### 8. Practical Differences

- **Cookie-Based**:
  - Great for traditional web apps or scenarios where the browser handles most of the authentication complexity.
  - Easier to manage session state, especially for short-lived sessions.
  - Requires server-side storage of sessions or user state.

- **JWT-Based**:
  - Better for SPAs, mobile apps, and microservices.
  - Completely stateless and scalable.
  - **Slightly more prone to XSS if not handled carefully (avoid storing in `localStorage` for sensitive apps)**.

---

### Final choice

We're going with Token-based authentication (JWT) due to several reasons:

- simplifies cross-origin handling.
- has a stateless nature, so we don't have to keep track of sessions in the server.
- mitigates CSRF risks as cookies will be sent automatically with every request to the cookie domain.
- can encode more data (custom claims, user role, permissions...).
- local development with cookies can be troublesome (no https, different domains/ports).
- because we're serving frontend and backend from different URLs, if we use cookies, we won't be able to take full advantage of its security aspects, as for example we won't be able to use `SameSite=Strict`.
- aligns more with the nature of this project (microservices + SPA).
