import { AmplifyProjectInfo, AmplifyRootStackTemplate } from '@aws-amplify/cli-extensibility-helper';

export function override(resources: AmplifyRootStackTemplate, amplifyProjectInfo: AmplifyProjectInfo) {
  const authRole = resources.authRole;

  const basePolicies = Array.isArray(authRole.policies)
    ? authRole.policies
    : [authRole.policies];

  authRole.policies = [
    ...basePolicies,
    {
      policyName: "invokeStartStopLambda",
      policyDocument: {
        Version: "2012-10-17",
        Statement: [
          //? Route calculator
          {
            "Effect": "Allow",
            "Action": [
              "lambda:InvokeFunction"
            ],
            "Resource": [
              "arn:aws:lambda:us-east-2:988119534577:function:startStopLambda-deve",
              "arn:aws:lambda:us-east-2:988119534577:function:processBarcodeLambda",
              "arn:aws:lambda:us-east-2:988119534577:function:dinov2weaviate-lambda"
            ]
          },
        ],
      },
    },
  ];
}
