

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
        xfbml      : true
        version    : 'v2.0'
      )

    do (d = document, s = 'script', id = 'facebook-jssdk') ->
      fjs = d.getElementsByTagName(s)[0]
      if d.getElementById(id) then return
      js      = d.createElement(s)
      js.id   = id
      js.src = "//connect.facebook.net/en_US/sdk.js"
      fjs.parentNode.insertBefore(js, fjs)

  ]