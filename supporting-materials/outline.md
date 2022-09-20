Troubleshoot.sh Workshop
=================

Source code for a workshop presented at DevOps Days Chicago 2022.

This content is very much a standing-on-the-shoulders-of-giants presentation. 
Special thanks to @jdewinne for code and content contributions that made this track what it is today.


### Overview

- Introduction - What this toolkit is for
  - ways to deploy software
    - 1st/3rd
    - 1st/1st with silos
    - tshoot corner
  - Break glass - if kubectl works, this will work. No SIEM/ELK/etc required.
    - unix -- small sharp tools
  - Runbooks to throw over the wall - when the person running it is not the person who wrote it
    - this is a devops conference why are you building tools for the wall? - we'll get there 
  - Faster than playing 20 questions with kubectl
  - Distribution vs. Delivery - packaged software vs. fully integrated
- deploy the app
- Without troubleshoot
  - kubectl get svc
  - kubectl get pod
  - kubectl describe pod / kubectl get event
  - k top node
  - k top pod
  - **cluster resize**
  - kubectl get pod
  - kubectl logs pod
  - kubectl logs pod | grep 'ERROR'
  - **kubectl edit pod / remove annotation**
- there must be a better way
- with troubleshoot
  - kubectl support-bundle
  - **cluster resize**
  - kubectl support-bundle
  - **kubectl patch**
- Hands on with the basics of Troubleshoot.sh
  - Collecting available cluster cpu
  - Analyzing available cluster cpu
    - adding a node
    - reverse-testing our analyzer
  - Analyzing workload status
  - Collecting Pod Logs
  - Analyzing Pod Logs
  - Exercise for the workshop -- can you inspect that annotation without reading the logs?
  - Execing Pods
  - Exercise for the workshop -- can you analyze the output of the pod exec output?
- more exercises - my favorite spec:
  - num nodes
  - total memory
  - available memory
  - total cpu
  - available cpu
  - total storage
  - available storage
  - pod statuses
- Cultural change / what's this got to do with DevOps
  - Runbooks to throw over the wall - when the person running it is not the person who wrote it
  - DevOps culture -- Prem -> SaaS -> some mix where you're doing a bit of both. Who owns the servers
  - Pain points - can't deploy 100x per day, 100 different environments, repaving 10x/month - throwing people at the problem. 
    - When its the same everywhere, you can automate. When it's not, you need people who can improvise
    - These people have many names -- Solutions Eng, Customer Success Engineers, Developer Advocates common for OSS
    - People whose job gets easier when it's easier for someone who **knows nothing about the app** to get it up and running 
  - practices
    - What are top teams doing
    - ride alongs - both directions
    - 50/50 split in skills / time (or at least 70/30) - distribution as a product function
    - take a note from SRE -- use SOFTWARE, not documentation or people
    - shift left - pull field SMEs into product development
  - metrics
    - DORA and devops work great - 4 key metrics
    - Deployment Frequency / Lead Time - what's definition of done?
       - in saas, its either deployed or not deployed
       - when you have 100 instances in the field -- median age of deployed software
    - Time to live in new environment
    - Mean time between failures -- change fail rate works when you are deploying 100x/day, but when an app doesn't get touched for 3 months and then falls over because the disk fell up -- hopefully they have backups, and hopefully they firedrill their backups. But often an overfilled disk can take 10+ hours to recover when the Ops team doesn't understand the app. Point is you can't just count 
    - These are just a few examples. If you can't measure it you can't improve it. 
    - DORA and devops work great - 4 key metrics, there's some other ones that are emerging as relevant
    - I don't know what you call this -- 
      - Field Reliability Engineering
      - DevPremOps
      - Continuous On-Premery
- What to do next
  - Write a spec
  - Host it somewhere
  - Add to your practice - write a dashboard, write an alert, then write a collector/analyzer
- other resources
  - Rethinking observability for OTS tools
  - Trelore troubleshoot
  - Kubecon plug, core devs will be there
