# SWIFT Client Connectivity Using Terraform Partner Solution on AWS—Terraform module

This Amazon Web Services (AWS) Partner Solution uses a [Terraform module](https://registry.terraform.io/modules/aws-ia/<path>/latest) to deploy a reference deployment in the AWS Cloud so that <purpose>. This solution is for <target users> who want to <do what> so that <why>. 

For more information, refer to the [<product name> documentation](<URL>).

This Partner Solution was developed by <partner name> in collaboration with AWS. <partner name> is an [AWS Partner](<URL for the partner's APN page; find it at https://partners.amazonaws.com/>).

Deploying this solution does not guarantee an organization’s compliance with any laws, certifications, policies, or other regulations. 

<!-- Authors: Uncomment the previous line only if your solution relates to compliance. We'll add the corresponding reference part to the landing page and get legal approval before publishing. -->

## Costs and licenses

This deployment requires a SWIFT account and software license. To register for a SWIFT account, refer to [How to become a swift.com user?](https://www.swift.com/myswift/how-to-become-a-swift_com-user_)

<!-- Authors: Modify or delete the previous statement. -->

There is no cost to use this Partner Solution, but you'll be billed for any AWS services or resources that this Partner Solution deploys. For more information, refer to the [AWS Partner Solution General Information Guide](https://fwd.aws/rA69w?).

## Architecture

This Partner Solution deploys into an existing VPC.

<!-- Authors: If this solution doesn't deploy into an existing VPC, delete the preceding "or into an existing VPC." -->

![Architecture for <product> on AWS](https://raw.githubusercontent.com/aws-ia/<repo>/main/images/<product>-architecture-diagram.png)

<!-- Authors: Use absolute links (starting with https://) for all your URLs, including images and other webpages. Relative links do not work when the readme content is pulled into the Terraform Registry page. For images, in particular, the absolute link must start with https://raw.githubusercontent.com; mimic the structure of the preceding example. -->

<!-- Authors: When you create your architecture diagram and corresponding bulleted list, follow the instructions in the "Architecture Diagrams" section of this course: https://aws-ia-us-west-2.s3.us-west-2.amazonaws.com/docs/content/index.html#/ -->

<!-- Authors: Put all image files in the main branch's images folder. For the architecture diagram, include a .png file and its up-to-date source .pptx file (as an editable file, not an image pasted into a slide). -->

As shown in the diagram, this solution sets up the following:
* An architecture that spans two Availability Zones.
* A VPC configured with private subnets, according to AWS best practices and following SWIFT Customer Security Programme (CSP) guidance, to provide you with your own virtual network on AWS.
* In the private subnets:
* An Amazon Elastic Compute Cloud (Amazon EC2) instance that runs Alliance Messaging Hub (AMH) and SWIFT Alliance Access (SAA) or Lite2.
* An EC2 instance that runs SWIFT Alliance Gateway (SAG) and SWIFTNet Link (SNL).
* (Optional) An Amazon Relational Database Service (Amazon RDS) Oracle instance running in active or standby mode to store configuration and message data for AMH. 
* (Optional) An Amazon MQ instance to handle communication for AMH. 
* AWS Systems Manager, which removes the need for a jump server.
* Amazon CloudWatch, which provides the mechanism to store, access, and monitor SWIFT activities.
* AWS Secrets Manager, which encrypts, stores, and retrieves passwords.
* A virtual private network (VPN) gateway with load balancing, which connects the VPC to AWS Direct Connect.*
* AWS Direct Connect, which establishes private connectivity between AWS and data centers or colocation environments.*

*The Terraform module that deploys this solution, does not include the components marked by asterisks because they require design decisions on how to connect to the SWIFT network.

<!-- Authors: The preceding line is a footnote for use with solutions that deploy into an existing VPC. If you keep the footnote, add asterisks to the appropriate bulleted items. -->

## <other sections as needed>

## Customer responsibility

After you deploy this Partner Solution, confirm that your resources and services are updated and configured—including any required patches—to meet your security and other needs. For more information, refer to the [AWS Shared Responsibility Model](https://aws.amazon.com/compliance/shared-responsibility-model/).
