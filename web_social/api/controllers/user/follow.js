module.exports = async function(req, res) {
  console.log('User id to follow: ' + req.param('id'));

  // association
  const currentUserId = req.session.userId;
  const userIdToFollow = req.param('id')
  
  await User.addToCollection(currentUserId, 'following', userIdToFollow);

  // first fina all post objects from user i am following
  const postsForUserImFollowing = await Post.find({user: userIdToFollow});
  postsForUserImFollowing.forEach(async p => {
    console.log(p.text);
    await FeedItem.create({
      post: p.id,
      postOwner: userIdToFollow,
      user: currentUserId,
      postCreatedAt: p.createdAt
    });
    console.log("Finished creating feed item")
  });

  // gen feed items

  await User.addToCollection(userIdToFollow, 'followers', currentUserId);

  res.end();
}