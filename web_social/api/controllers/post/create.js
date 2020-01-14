module.exports = async function(req, res) {
  const postBody = req.body.postBody;
  console.log('Create post object with text: ' + postBody);

  const file = req.file('imagefile');

  const fileUrl = await sails.helpers.uploadfile(file);

  const userId = req.session.userId;
  await Post.create({ 
    text: postBody, 
    user: userId, 
    imageUrl: fileUrl});

  res.end();

  return;
}