jQuery(document).on 'turbolinks:load', ->
#  Function called on tubolinks:load
  comments = $('#comments')


  # Get the comments div - check the length on the object assocaited with the identifier
  if comments.length > 0
    # If the identifier exists, set up a new subscription to actioncable
    App.global_chat = App.cable.subscriptions.create{
      # Name the channel;
      channel: "BlogsChannel"
      # Get the blog id from the data structure in the @blog.show view
      blog_id: comments.data('blog-id')
    },
    connected: -> #Do nothing on connect
    disconnected: -> #Do nothing on discconect
    received(data) -> # On recied perform the function
      # Subtly insert the new comment under the hood, on the 'comments div
      comments.append data['comment']
      # Now we need to add method, for sending the comment data to the database,
      # after it has been added to the view
    send_comment: (comment, blog_id) ->
      @perform 'send_comment', comment: comment, blog_id: blog_id

  # With the scope of the comment form, when submitted, we will perform the following function
  $('#new_comment').submit(e) ->
    $this = $(this)
    textarea = $this.find('#comment_content')
    # Trim wehitespace and check length of cmment before thinking of sending it to the database
    if $.trim(textarea.val()).length > 1
      # Get an instance of global_chat and use the send comment function defined above
      App.global_chat.send_comment textarea.val(),
      comments.data('blog-id')  # Send the blog_id
      textarea.val('')          # Set the string to nil after sending
    # Prevent the HTTP form from reloading the page
    e.preventDefault()
    return false # Exit the scope of this function