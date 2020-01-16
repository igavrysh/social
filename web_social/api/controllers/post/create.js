module.exports = async function(req, res) {
  const postBody = req.body.postBody;
  console.log('Create post object with text: ' + postBody);

  const file = req.file('imagefile');

  try {
    const fileUrl = await sails.helpers.uploadfile(file);

    const userId = req.session.userId;
    const postRecord = await Post.create({ 
      text: postBody, 
      user: userId, 
      imageUrl: fileUrl}).fetch();
  
    // we are inserting FeedItem for the current user
    await FeedItem.create({
      post: postRecord.id,
      postOwner: userId,
      user: userId,
      postCreatedAt: postRecord.createdAt});
  
    // In now going to insert a FeedItem for all of my followers
    const user = await User.findOne({id: userId})
      .populate('followers');

    user.followers.forEach(async f => {
      console.log(f.fullName);
      await FeedItem.create({
        post: postRecord.id,
        postOwner: userId,
        user: f.id,
        postCreatedAt: postRecord.createdAt});
    });

    res.end();
  } catch(err) {
    res.serverError(err.toString())
  }
}