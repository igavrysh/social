module.exports = async function(req, res) {
  console.log("Trying to update user");

  const fullName = req.body.fullName;
  const bio = req.body.bio; 

  console.log(fullName);
  console.log(bio);

  const file = req.file('imagefile');
  console.log(file);

  // no avatar file change was found
  if (file.isNoop) {
    await User.update({id: req.session.userId})
    .set({fullName: fullName, bio: bio});

    file.upload({noop: true});
    return res.end();
  }

  //  I'll handel the avatar later 

  const options = {
    adapter: require('skipper-better-s3'),
    key: '',
    secret: '',
    bucket: 'gvr-social-bucket',
    s3params: {ACL: 'public-read'}
  }

  file.upload(options, async (err, files) => {
    if (err) {
      return res.serverError(err.toString());
    }
    const fileUrl = files[0].extra.location;
    await User.update({id: userId})
      .set({
        fullName: fullName, 
        bio: bio, 
        profileImageUrl: profileImageUrl}).fetch();
    res.end();
  });

}