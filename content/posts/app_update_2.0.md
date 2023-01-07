Title: Another Project Update!
Author: Jack DesCombes
Date: 2022-10-17

It’s been a long time since I’ve written a project update, and since my last post, I’ve been back to working consistently on my wellness dashboard project since July. Rather than write a long wall of text, here’s a list of some of the features I’ve been able to tack on the past few months.

[Jack’s Wellness App](server.jpdesc.com)

- Added icons to calendar and dashboard
- Automated deployment on virtual Ubuntu server via Ansible
- Insights page where I can filter the data based on my tags
- Workout template module to set up a base template for my weights workouts
- Live editing of weights workouts via REST API. I can now log my workouts from my phone!
- Cryptographically secured user login system
- Scores added to calendar
- Refactored code into distinct modules using Flask blueprints. This has made the project much cleaner and easier to work in!
- Refactoring of most of the code! As I’ve continued to add to the project, I’ve realized how much easier it is to work with clean, modularized code. My skills have also greatly improved, so of course I am finding areas to improve as I go.
- Automated database backup scripts to AWS S3 cloud service.

I am currently in the process of expanding my testing suite, and have begun working with Jenkins, a popular CI/CD platform that will help ensure that successive code changes to my production server won’t break the app. I am also going to dive into AWS quite a bit more as I look to round out my skillset in preparation for the job market.
