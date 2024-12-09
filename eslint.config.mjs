import { FlatCompat } from '@eslint/eslintrc';
import js from '@eslint/js';
import parser from 'astro-eslint-parser';
import globals from 'globals';
import path from 'node:path';
import { fileURLToPath } from 'node:url';

const __filename = fileURLToPath(import.meta.url);
const __dirname = path.dirname(__filename);
const compat = new FlatCompat({
  baseDirectory: __dirname,
  recommendedConfig: js.configs.recommended,
  allConfig: js.configs.all
});

export default [
  {
    ignores: ['dist/**/*', '**/.eslintrc.cjs', 'tf/**/*']
  },
  ...compat.extends(
    'eslint:recommended',
    'plugin:astro/recommended',
    'plugin:astro/jsx-a11y-strict',
    'plugin:prettier/recommended'
  ),
  {
    languageOptions: {
      globals: {
        ...globals.browser,
        ...globals.node
      },

      ecmaVersion: 2020,
      sourceType: 'module'
    }
  },
  {
    files: ['**/*.astro'],

    languageOptions: {
      parser: parser,
      ecmaVersion: 5,
      sourceType: 'script',

      parserOptions: {
        parser: '@typescript-eslint/parser',
        extraFileExtensions: ['.astro']
      }
    },

    rules: {}
  }
];
