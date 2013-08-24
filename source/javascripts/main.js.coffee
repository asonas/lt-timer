handlers =
  tweet: (data) ->
    user = data.user
    if user
      id = data.id_str
      text = data.text.replace("#kosenconf", "")
      screen_name = user.screen_name
      profile_image_url = user.profile_image_url
      div = $("<div/>").addClass("tweet").append($("<p/>").append($("<img/>").addClass("icon").attr(
        src: profile_image_url
        alt: screen_name
        width: 36
        height: 36
      )).append($("<span/>").addClass("screen_name").append($("<a/>").attr(
        href: "http://twitter.com/" + screen_name + "/status/" + id
        target: "_blank"
      ).text(screen_name))).append(text))
      $("#timeline").prepend div

$ ->
  timer = ''
  $(document).on "click", ".clear", =>
    remein = 60 * 5
    $("#timmer").text(remein)
    clearInterval(timer)

  $(document).on "click", ".start", =>
    remein = 60 * 5
    timer = setInterval ->
      remein = remein - 1
      $("#timmer").text(remein)
    , 1000

  pusher = new Pusher('FIX ME')
  stream = pusher.subscribe("stream")
  stream.bind("tweet-kosenconf", handlers["tweet"])
