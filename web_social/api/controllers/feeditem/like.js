module.exports = async function(req, res) {
  const postId = req.param('id');
  try {

    await FeedItem.update({
      post: postId,
      user: req.session.userId
    }).set({hasLiked: true});


    console.log('creating like for postId: ' + postId + ' user: ' + req.session.userId);

    var createdLike = await Like.create({
      post: postId,
      user: req.session.userId
    }).fetch();

    console.log('createdLike: ' + createdLike);

    var t = await Post.findOne({id: postId}).populate('likes');

    t.likes.forEach(l => {
      console.log("like: " + l.id);
    });

    const numLikes = await Like.count({post: postId});

    await Post.update({
      id: postId
    }).set({numLikes: numLikes});

    res.end();
  } catch(err) {
    res.serverError(err.toString());
  }
}