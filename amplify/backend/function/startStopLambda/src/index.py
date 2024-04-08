import json
import time
import boto3
import os

ssm_client = boto3.client('ssm')

def handler(event, context):
    cognitoID = context.identity.cognito_identity_id if context.identity.cognito_identity_id is not None else ""
    
    #instanceID = event['body'] # obtain from QR code on Jetson
    
    # get barcode Python script directory from environment variable
    startScript = '''
    cd {}
    . barcode_venv/bin/activate
    nohup python barcode3.py {} >/dev/null 2>&1 &
    '''.format(os.environ.BARCODE_DIRECTORY, cognitoID)
    
    stopScript = """
    cd {}
    kill `cat app.pid`
    """.format(os.environ.BARCODE_DIRECTORY)
    
    script = ""
    
    # describe all managed IoT instances
    response = ssm_client.describe_instance_information(
        Filters=[
            {
                'Key': 'AssociationStatus',
                'Values' : ['Success']
            },
            {
                'Key': 'PingStatus',
                'Values' : ['Online']
            },
            {
                'Key': 'PlatformTypes',
                'Values' : ['Linux']
            },
            {
                'Key': 'ResourceType',
                'Values' : ['ManagedInstance']
            },
            {
                'Key': 'SourceTypes',
                'Values' : ['AWS::IoT::Thing']
            },
            # {
            #     'Key': 'tag:deviceType',
            #     'Values': ['JetsonNano']
            # },
        ]
    )
    
    # Get Jetson instance IDs
    instances = []
    for instance in response['InstanceInformationList']:
        print("{} instance found".format(instance['ComputerName']))
        instances += [instance['InstanceId']]
        
        
    # Determine which commands to send    
    if event['body']['Command'] == "START":
        script = startScript
    elif event['body']['Command'] == "STOP":
        script = stopScript
    else:
        return {
            'statusCode': 400,
            'body': '',
            'error': 'Invalid command received'
        }
    
    # send command to Jetson Nano
    command_res = ssm_client.send_command(
        DocumentName = 'AWS-RunShellScript',
        Parameters = {'commands': [script]},
        InstanceIds = instances
    )
    
    time.sleep(1)
    
    # get command results
    command_invoc_res = ssm_client.get_command_invocation(
        CommandId = command_res['Command']['CommandId'],
        InstanceId = command_res['Command']['InstanceIds'][0]
    )
    
    status = command_invoc_res['Status']
    statusDetails = command_invoc_res['StatusDetails']
    
    res = {
        'InstanceID': command_invoc_res['InstanceId'],
        'Status': status,
        'StatusDetails': statusDetails
    }
    
    return {
        'statusCode': 200,
        'headers': {
          'Access-Control-Allow-Headers': '*',
          'Access-Control-Allow-Origin': '*',
          'Access-Control-Allow-Methods': 'OPTIONS,POST,GET'
        },
        'body': json.dumps(res),
        'error': ""
    }