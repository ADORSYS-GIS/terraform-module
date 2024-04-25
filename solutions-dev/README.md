# Terraform for AWS Solutions Project

ToDo: 
- [ ] r53 outputs errors
- [ ] SecGroups check
- [ ] r53 routes to alb alias
- [ ] setup different environments
    - new ec2 machine per environment?
    - another docker network and domain for other environment on same ec2?
- [ ] access mgmt? 
    - create aws user and access keys for developer?
    - start/stop instance with lambda?
    - ssh?
    - script?

    - Usecase: 
        - Developer wants to test his code in a shared environment
        - Developer start ec2 with flag for env (support or develop , xs2a, modelbank etc.)
        - Developer can see changes in shared environment
        (- Developer needs to interact with environment - like logs?)
        - Developer shuts down shared Environment


This is a mockup of the IaC Code in this Project
---
![mock aws](.assets/AWS-mock.png)
