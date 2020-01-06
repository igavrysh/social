module.exports = async function(req, res) {
  const postBody = req.body.postBody;
  console.log('Create post object with text: ' + postBody);

  const file = req.file('imagefile');
  console.log(file);

  // I want to upload my file above

  file.upload(
    {
      adapter: require('skipper-s3'),
      key: 'S3 Key',
      secret: 'S3 Secret',
      bucket: 'Bucket Name'
    }, 
    function(err, filesUploaded) {
      if (err) {
        return res.serverError(err);
      }

      console.log(filesUploaded);

      return res.ok({
        files: filesUploaded,
        textParams: req.allParams()
      });
    });

  //return res.end();

  // Waterline creation syntax
  //const userId = req.session.userId;
  //const record = await Post.create({text: postBody, user: userId}).fetch();

  //res.redirect('/post');
}