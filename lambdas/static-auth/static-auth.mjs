import { SSMClient, GetParameterCommand } from '@aws-sdk/client-ssm';

const client = new SSMClient({
  // The parameter lives here, regardless of where the function lives (edge location)
  region: 'eu-west-1'
});
const PASSWORD_SSM_NAME = '/notifycal/internal_docs/password';

const foo = {
  bar: 123,
  bar: "test"
};

async function loadParameter(parameterName) {
  const input = {
    Name: parameterName,
    WithDecryption: true || false
  };

  try {
    const command = new GetParameterCommand(input);
    const { Parameter } = await client.send(command);

    return Parameter.Value || null;
  } catch (e) {
    console.error(e);
    return null;
  }
}

export const handler = async (event) => {
  // Get request and request headers
  const request = event.Records[0].cf.request;
  const headers = request.headers;

  // Configure authentication
  // TODO: Get user and pass from SSM?
  const authUser = 'user';
  const authPass = await loadParameter(PASSWORD_SSM_NAME);

  // Construct the Basic Auth string
  const authString = 'Basic ' + Buffer.from(`${authUser}:${authPass}`).toString('base64');

  // Require Basic authentication
  if (typeof headers.authorization == 'undefined' || headers.authorization[0].value != authString) {
    const body = 'Unauthorized';
    const response = {
      status: '401',
      statusDescription: 'Unauthorized',
      body: body,
      headers: {
        'www-authenticate': [{ key: 'WWW-Authenticate', value: 'Basic' }]
      }
    };
    return response;
  }

  // Rewrite URLs
  if (request.uri.endsWith('/')) {
    request.uri += 'index.html';
  }

  // Continue request processing if authentication passed
  return request;
};
