

# =============================================
# Module
# =============================================
angular.module 'MyAngularOmakase'

  # =============================================
  # Initialize
  # =============================================
  .run [ ->

    # Facebook SDK
    # =================================
    window.fbAsyncInit = () ->
      FB.init(
        appId      : 'XXXXXXX' # Change XXXXXXX to your AppId
        xfbml      : yes
        version    : 'v2.1'
        status     : yes
        oauth      : yes
        cookie     : yes
      )

    do (d = document, s = 'script', id = 'facebook-jssdk') ->
      fjs = d.getElementsByTagName(s)[0]
      if d.getElementById(id) then return
      js      = d.createElement(s)
      js.id   = id
      js.src = "//connect.facebook.net/en_US/sdk.js"
      fjs.parentNode.insertBefore(js, fjs)

  ]