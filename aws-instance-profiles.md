Show CLI profiles:

```
aws configure list
```


Make json with trusted policy
vim :set paste

```
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {"Service": "ec2.amazonaws.com"},
      "Action": "sts:AssumeRole"
    }
  ]
}
```



Create a developer role

```
aws iam create-role --role-name developer_role --assume-role-policy-document file://trusted_policy.json
```

Create s3 access policy file
```
{
    "Version": "2012-10-17",
    "Statement": [
        {
          "Sid": "ListAllS3Buckets",
          "Action": ["s3:ListAllMyBuckets", "s3:GetBucketLocation"],
          "Effect": "Allow",
          "Resource": ["arn:aws:s3:::*"]
        },
        {
            "Effect": "Allow",
            "Action": [
                "s3:Get*",
                "s3:List*"
            ],
            "Resource": [
                "arn:aws:s3:::<s3_bucket>/*",
                "arn:aws:s3:::<s3-bucket>"
            ]
        }
    ]
}
```
Create s3 access policy 

```
aws iam create-policy --policy-name S3DeveloperAccess --policy-document file://s3_access_developers.json
```


Attach managed policy to the role

```
aws iam attach-role-policy --role-name developer_role --policy-arn "<S3DeveloperAccess_ARN>"
```

Verify the managed policy was attached:
```
aws iam list-attached-role-policies --role-name developer_role
```

Create the Instance Profile and Add the developer_role 
```
aws iam create-instance-profile --instance-profile-name developer_profile
```
Add role to the developer_profile:

```
aws iam add-role-to-instance-profile --instance-profile-name developer_profile --role-name developer_role
```

Verify the configuration:

```
aws iam get-instance-profile --instance-profile-name developer_profile
```

Attach the developer_profile Role to an Instance

```
aws ec2 associate-iam-instance-profile --instance-id <instance id> --iam-instance-profile Name="developer_profile"
```
Verify the configuration

```
aws ec2 describe-instances --instance-ids <instance id>
```


Make check on target instance

```
aws sts get-caller-identity
```

Show buckets

```
aws s3 ls
aws s3 ls s3://<bucket>
```

