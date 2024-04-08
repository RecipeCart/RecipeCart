const { Sha256 } = require("@aws-crypto/sha256-js");
const { defaultProvider } = require("@aws-sdk/credential-provider-node");
const { SignatureV4 } = require("@aws-sdk/signature-v4");
const { HttpRequest } = require("@aws-sdk/protocol-http");
const { default: fetch, Request } = require("node-fetch");

const GRAPHQL_ENDPOINT = process.env.API_RECIPECART_GRAPHQLAPIENDPOINTOUTPUT;
const GRAPHQL_API_KEY = process.env.API_RECIPECART_GRAPHQLAPIKEYOUTPUT;
const AWS_REGION = process.env.REGION || 'us-east-2';

const query = /* GraphQL */ `
  mutation createUserSettings($email: String!,$owner: String!) {
    createSettings(input: {
      email: $email,
      owner: $owner,

      dietType: 0,
      cuisineTypes: [],
      savedRecipes: [],
      likedRecipes: [],
      avoidances: [],
      language: 0,
      notifications: false,
      linkedDevices: []
    }) {
      email
      owner
      id
    }
  }
`;




/**
 * @type {import('@types/aws-lambda').PostConfirmationTriggerHandler}
 */
 exports.handler = async (event) => {
  console.log(`EVENT: ${JSON.stringify(event)}`);


  const variables = {
    
      email: event.request.userAttributes.email,
      owner: `${event.request.userAttributes.sub}::${event.userName}`
    
  };






  const endpoint = new URL(GRAPHQL_ENDPOINT);

  const signer = new SignatureV4({
    credentials: defaultProvider(),
    region: AWS_REGION,
    service: 'appsync',
    sha256: Sha256
  });

  const requestToBeSigned = new HttpRequest({
    method: 'POST',
    headers: {
      'Content-Type': 'application/json',
      'x-api-key': GRAPHQL_API_KEY,
      host: endpoint.host
    },
    hostname: endpoint.host,
    body: JSON.stringify({ query, variables }),
    path: endpoint.pathname
  });

  const signed = await signer.sign(requestToBeSigned);
  const request = new Request(endpoint, signed);

  let statusCode = 200;
  let body;
  let response;

  try {
    response = await fetch(request);
    body = await response.json();
    if (body.errors) statusCode = 400;
  } catch (error) {
    statusCode = 500;
    body = {
      errors: [
        {
          message: error.message
        }
      ]
    };
  }

  console.log(`statusCode: ${statusCode}`);
  console.log(`body: ${JSON.stringify(body)}`);

  return {
    statusCode,
    body: JSON.stringify(body)
  };
};