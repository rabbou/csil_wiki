---------------
Webint is short for  **Web  Int** ernal and covers all of our software that is designated for internal use. 
This page contains information about software on webint and the development of this software. 
Web-int has 5 major domains: web-int (administrative), schedule, labstats, inventory, and kiosks. 
The rest is a link to the external tools currently in use.

##Administrative Interface

One of the most important aspects of webint in the administrative interface. 
This can be found [here](https://webint-vl1.cs.uchicago.edu/admin/) and [here](https://webint-vl1.cs.uchicago.edu/admin/). 
The user name and password should be in the password binder and OnePass. 
Here you can see all the internal models used by webint and edit them as necessary. 
More details about specific fields can be found in the subsections dealing with those applications.


##User Authentication

Web-int uses ldap authentication, so tutors should be able to login with just their cnet/password combination. 
However, we are also using a whitelist to control access to various parts of the site. 
If a user is not on the whitelist, they will receive 403 errors for any page they are not authorized to view. 
To add a user to the whitelist, first navigate to the administrator interface (see above), and select “Whitelisted users”. 
Create a new whitelisted user and add set the name to the users CNET id. 
Then select the privileges that the user should have. 

- Tutors: Can access every page on the site (with the exception of the wiki). 
- Wikiusers: Can access the wiki. Any tutors should belong to the groups “tutors” and “wikiusers”.

##Schedule
See scheduling information [here](https://repo-vl1.cs.uchicago.edu/csil/csil-wiki/raw/master/pages/Web-int/webint_schedule.md)

##Labstats

Labstats in a Django based system that tracks the usage of the machines present in the lab and allows us to examine usage trends and notice any potentially malicious behavior.

* See Activity Monitoring Meisterdom

* The State Of Labstats as of 2016

[This](https://repo-vl1.cs.uchicago.edu/csil/csil-wiki/blob/master/pages/Activity_Monitoring/labstats_tour.md) provides a good overview of labstats functionality and its codebase and serves as a good springboard for further research. 

##Kiosks

Kiosk is a system that generates rotating slides for display in a web browser. Slides may (currently) be webpages, images, or QuickTime movies. It is used to run the information displays at the southern end of the lab and by the tutor station.

Kiosk Template:

Here is the template used for making kiosk slides: [https://webint-vl1.cs.uchicago.edu/wiki/labsoftware/web-int/kiosk]

##Developing Web-int: 

Web-int is built in Django. To develop in web-int, read through the Django documentation on writing your first Django app carefully, as it give you a good overview of the framework that we use. Next, use the "Getting Started" page to set up a local copy of web-int and spend some time exploring the code base. Once you have a good gist of where things are, you're ready to work on Webint!

###Django Overview: 

* Theory

Django is a web framework. It allows us to focus more on development and less on all of the boilerplate that a web application needs. That is, we get to write programs without worrying about all the pieces of running the code and networking the site itself.

The documentation for Django is quite good. You can start here or just jump right into the reference material.

* Practice

Top Level: To put the beginning of the tutorial linked above into a little perspective, we can rewrite the tree using the Django app we already have, WebInt. The highest level of our WebInt repository does not in fact hold any Django material. It is not until you move down into the first “webint” folder that you get to the actual site. Thus we have (ignoring some miscellany):

```
webint/
    inventory/
    kiosk/
    labstats/
    manage.py
    schedule/
    splatadmin/
    static/
    webint/
```

To start, we have “manage.py”. This is a script provided by Django that lets us (shockingly) manage our site. When run by itself, it just lists all the commands you can give it. Most of the built-in ones are under the header [django], while our modules have some of their own commands. “runserver” is one of the simplest ones, and it starts the server locally for you to look at. You can see its usage in the getting started documentation here.

Static is just a bucket for holding files that don't change. Here you will find images, css definitions, fonts, javascript, etc. These don't change under typical usage of the site, so Django can just store cached copies to speed itself up. NOTE: These files do not have to only exist here. You can place them inside of modules for better design, and then let Django collect them into this folder. This lets us keep images or css with the code that uses it, while Django still gets the speed-ups from serving from a single folder.

* App Level
Apart from the two mentioned above, every file or directory shown above is an app. These are accessed using the lovely buttons on the front page of WebInt. Following the tutorial linked at the beginning, we will start with the webint app and then move on to the ones we have created.

```
webint/
    webint/
        __init.py__
        development_settings.py
        shared_settings.py
        production_settings.py
        static/
        templates/
        urls.py
```

init.py is present in every app directory, and it lets Python recognize this folder as a module. You should never need to edit it. The *_settings.py* files all define settings used to run the server. shared_settings.py contains settings that are always used, while dev and production are specifically for the dev and production environments. These settings cover preferences ranging from timezone to databases to apps to load.

Static is exactly like the static we saw earlier, but this one keeps the files closer to the code. One of the manage.py commands, “collectstatic”, reaches into all the app directories and pulls all of the static files out into the top level static folder. Thus, this static folder should contain files that will not change, and are related to webint directly (e.g. css, images, fonts). collectstatic will grab all the files here so that Django can serve them quickly and efficiently.

Templates are files that use Django's templating language. They can be written using any extension (.txt, .html, etc.). See here for examples and more information. Also, refer to our current usages for inspiration and elucidation.

Finally, urls.py manages the handling of incoming requests. If I go to https://webint-vl1.cs.uchicago.edu/login, Django knows to load the login page for me. If I try https://webint-vl1.cs.uchicago.edu/labstats/rev, this urls.py file read up to labstats, and then passes the rest onto the labstats module's version of urls.py.

Turning toward a more common example, we look at labstats. Most of the apps we develop follow this pattern a little more closely, but it's good to know the core works.

```
webint/
    labstats/
        __init.py__
        models.py
        static/
        templates/
        urls.py
        views.py
```

init.py, static, templates, and urls.py are the same as above. Which leaves us with models.py and views.py. These two (roughly) follow a standard of web design called Model-View-Controller.

models.py defines our data. For labstats, that means we are primarily checking machines and login sessions. This file defines a machine as various database fields. A character field for the name, a character field for the type (mac/linux), a date/time field for the last rev, and so on. This handles all of the database management for us. We simply define our objects here, and Django does the database work for us. Which is good because databases suck.

views.py defines our web pages. They are url end points. So if I wanted a page that showed the data of a single machine, I might want a page called https://webint-vl1.cs.uchicago.edu/labstats/machine. The urls.py file would have a line that said “when I get machine, I load X”, where X is a function in your views.py. These functions have access to all the data in your models, and so you might load a template, filling it with the data of a particular machine. See our current pages for examples.

From here, you should be prepped to learn all the other kinds of things you can do. We have many more kinds of files in our website, but this covers the core. Poke around those other files to see what else is possible and to see what has fallen into disrepair.

###Setting Up the Development Environment
See the instructions here: [https://repo-vl1.cs.uchicago.edu/csil/webint-vl2/blob/master/Installation.md]

###Development Guidelines: 

This page describes some best practices that we try to follow when developing on webint.

* Branching Structure

We use Git as our version control, using gitlab as a front end. Instead of having all of the code base on a single branch we have the following branching structure:

master: This is production ready code. This is what is run on our production servers. Do not commit straight to master
development: This is the main development branch. Weekly, we will merge development into master assuming that nothing has broken in development. This is also the parent branch of each new feature branch.
feature-branches: When you want to work on a new feature/bug fix you will create a descriptive branch for that specific feature. I.e. if you're working on a bug relating to sorting inventory reports you could make something called “fix_inventory_sorting” or analogous. This should be branched off of development and merged back into development. When you are done with your work submit a merge request through gitlab and make sure that somebody else reviews your code (this way at least one other person has an idea what's happening).

* Coding Style

Most of webint is written in python, so we do our best to follow PEP 8, with the exception that we use 100 characters as our maximum line length instead of 80. To make it easier to follow the style guide we have a make lint task. This will first run autopep8 to correct and whitespace issues and then run pylint to ensure that your code is up to standard. If pylint finds any errors (i.e. the score is less than 10.0) you should fix these before you submit a merge request. There are two ways to fix an issue: the first, and best choice, is to simply fix the issue. The second, less desirable, choice is to use a pylint ignore symbol (#pylint: disable=…). If you do this, please include a description of why you're ignoring the warning. Sometimes pylint is wrong, but it's not always easy to see why this is.

###Web-int 1.0
This page details all the workings of web-int 1.0 in general. This includes how to log into webint, how to use the administrative interface, and other miscellaneous topics.

Restarting Web-int 1.0: Web-int can be restarted by sshing into webint-vl1 and running ```sudo supervisorctl restart webint```

---------------