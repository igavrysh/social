# web-social

a [Sails v1](https://sailsjs.com) application


### Links

+ [Sails framework documentation](https://sailsjs.com/get-started)
+ [Version notes / upgrading](https://sailsjs.com/documentation/upgrading)
+ [Deployment tips](https://sailsjs.com/documentation/concepts/deployment)
+ [Community support options](https://sailsjs.com/support)
+ [Professional / enterprise options](https://sailsjs.com/enterprise)


### Version info

This app was originally generated on Tue Dec 31 2019 03:18:32 GMT-0800 (Pacific Standard Time) using Sails v1.2.3.

<!-- Internally, Sails used [`sails-generate@1.16.13`](https://github.com/balderdashy/sails-generate/tree/v1.16.13/lib/core-generators/new). -->


This project's boilerplate is based on an expanded seed app provided by the [Sails core team](https://sailsjs.com/about) to make it easier for you to build on top of ready-made features like authentication, enrollment, email verification, and billing.  For more information, [drop us a line](https://sailsjs.com/support).


# To run mongodb in docker

In command line, type in the following commands
```
docker pull mongo

docker run -d -p 27017-27019:27017-27019 --name mongodb mongo
```

In config/datasources.js include the following lines:
```
module.exports.datastores = {
  default: {
    adapter: 'sails-mongo',
    url:'mongodb://root@localhost:27017/mongodb'
  },
};
```


<!--
Note:  Generators are usually run using the globally-installed `sails` CLI (command-line interface).  This CLI version is _environment-specific_ rather than app-specific, thus over time, as a project's dependencies are upgraded or the project is worked on by different developers on different computers using different versions of Node.js, the Sails dependency in its package.json file may differ from the globally-installed Sails CLI release it was originally generated with.  (Be sure to always check out the relevant [upgrading guides](https://sailsjs.com/upgrading) before upgrading the version of Sails used by your app.  If you're stuck, [get help here](https://sailsjs.com/support).)
-->

### Deploying to heroku

```
git add .
git commit -m "Initial commit"
heroku git:remote -a socialapp-igavrysh

heroku login
heroku create socialapp-igavrysh

cat .git/config
git push heroku master
heroku open

heroku logs --tail

heroku run ls
ls assets/dependencies
```

Setting env variabales

```
heroku config

heroku config:set AWS_KEY=...
heroku config:set AWS_SECRET=...
```