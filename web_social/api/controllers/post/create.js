module.exports = async function(req, res) {
  const postBody = req.body.postBody;
  console.log('Create post object with text: ' + postBody);

  const file = req.file('imagefile');
  console.log(file);

  // I want to upload my file above

  const options = {
    adapter: require('skipper-better-s3'),
    key: '',
    secret: '',
    bucket: 'gvr-social-bucket',
    s3params: { ACL: 'public-read' },
    onProgress: progress => SVGPathSegList.log.verbose('Upload proress: ', progress)
  }

  file.upload(options, async (err, files) => {
    if (err) {
      return res.serverError(err.toString());
    }

    // success
    //res.send(files);
    //console.log(files);

    const fileUrl = files[0].extra.Location;

    const userId = req.session.userId;
    await Post.create({ 
      text: postBody, 
      user: userId, 
      imageUrl: fileUrl}).fetch();

    res.redirect('/post');
  });
}