# AWS EC2 & Docker


[Explanitory article](https://medium.com/p/d9059d1a8ac0/edit).

## Explaining the terraform file

First thing that you will want to do is to declare your provider. 
Terraform allows you to use a few different ones but for the purpose of this 
article we will be using AWS. The syntax for that is very straight forward.

Next we want to find our image. If we know what it is we can skip 
data source, since it is used to find the `image-id`. If you want 
more info on Data Source visit [here](https://www.terraform.io/docs/providers/aws/d/ami.html#filter).
Also a comprehensive list of filters for images can be found 
[here](https://docs.aws.amazon.com/cli/latest/reference/ec2/describe-images.html).
The AWS docs give us some help getting the most recent one by 
`image-id` by running the following command:

`$ aws ec2 describe-images --owners amazon --filters 'Name=name,Values=amzn2-ami-hvm-2.0.????????.?-x86_64-gp2' 'Name=state,Values=available' --query 'reverse(sort_by(Images, &CreationDate))[:1].ImageId' --output text`

We can do this


## Using Terraform
To build this in the cloud we first want to see what Terraform has planed. 
To do that we need to run:
`$ terraform plan`

Judging the output of the previous, if we are satisfied with what terraform
has planned we can now run:

`$ terraform apply --auto-approve`

The above will go off into the cloud and build out what we have planned in our
`node-test.tf` file. I like the `--auto-approve` flag because I am usually confident
in what I have planned in terraform and I want it to go ahead and build it
if I am running the `apply` command.

### But what if we screw something up...?

If we think we've messed up anywhere we can simply run:

`$ terraform destroy --auto-approve`

The previous command will remove the stack of anything we deployed with the current
terraform configurations.


## Important
Make sure you have your egress rules set up.
I caught holy hell trying to download from the internet
while inside of my newly terraformed EC2 instance and it was 
all because I did not properly set up outbound rules. I opened up 
port 80 and this allowed me to connect to the interet from within the 
instance.

Sure somebody with more network experience than I would
have naturally known this but to those with little to no 
networking experience like me make sure this is set.


If you need to use a ssh key here are some resources for that
[use ssh key with EC2](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/ec2-key-pairs.html)