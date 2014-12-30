# * === Alpha Version Coming Soon === *

# English

## Feature Scaffolding
A scaffolding not based on framework's structure, but only in features, settings of the project and web components.

## Problems
So you define your scaffolding according to your framework and what do you get? 
When we use BackboneJS you have an folder foreach structure: Models, Collections and Views.
And when we use AngularJS is the same thing, but you have a folders for Controllers, another one for Directives, Factories etc...

That's all right, but if you think that a view has a template you'll need another folder almost at the top level of your scaffolding only to contain the template files, and is the same thing for stylesheets, could be something like this:
 ```
  scripts/
   |-- controllers/
    |--myFeature (contains js files of myFeature)
  
  templates/
   |-- views/
    |-- myFeatureTemplates (contains html files of myFeature)
  
  styles/
   |-- views/
   myFeatureStyles (contains css files of myFeature)
 ```
 
All right, that works! But we have only one feature in our project, more and more will be implemented and we will get a lot of folders in our project. So if i ask to you extract or remove a feature from your project, would be easy?

### The first problem: Maintenance or remove a feature
We have to many files in to many diferent places to give maintenance to our feature. and I have not considered the test files, images and etc...
 Remove or extract something from here is a slow process, where you have to take care to be sure that you're not ruining your project forgeting something.
 
### Reuse components in another project
In AngularJS we can lose the power of `web components solution`, cause sometimes directives have templates and style an a diferent places too and the process of extract it becomes slow, again.
      
    

## Installation

```bash
$ cd <app-frontend-base-directory>
$ sudo npm install -g bower gulp
$ sudo npm install
$ bower install
```

## Authors

[![Carlos Henrique](https://avatars0.githubusercontent.com/u/2482989?v=3&s=96)](https://github.com/GabrielGarcia1) | [![Bruno Fachine](https://avatars3.githubusercontent.com/u/3225834?v=3&s=96)](https://github.com/BrunoDF)
--- | --- | --- | --- | --- | --- | ---
[Carlos Henrique](https://github.com/carloshpds)| [Bruno Fachine](https://github.com/BrunoDF)
