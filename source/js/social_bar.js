;(function (window, document, qrcdoe) {

  facebookAppId = '757753527686488'

  function getShareUrl (config) {
    var platform = config.platform
    var facebookAppId = config.facebookAppId
    var targetUrl = config.targetUrl
    var title = config.title
    var description = config.description
    var imageUrl = config.imageUrl

    targetUrl = targetUrl ? encodeURIComponent(targetUrl) : ''
    imageUrl = imageUrl ? encodeURIComponent(imageUrl) : ''

    var shareUrl

    if (platform === 'facebook') {
      shareUrl = 'https://www.facebook.com/dialog/feed?' +
        'app_id=' + facebookAppId +
        '&link=' + targetUrl +
        '&redirect_uri=' + targetUrl

      if (imageUrl) {
        shareUrl += '&picture=' + imageUrl
      }

      if (title) {
        shareUrl += '&name=' + title
      }

      if (description) {
        shareUrl += '&description=' + description
      }

      return shareUrl
    } else if (platform === 'sinaweibo') {
      return 'http://v.t.sina.com.cn/share/share.php?title=' + title + '&url=' + targetUrl
    } else if (platform === 'twitter') {
      return 'https://twitter.com/share?url=' + targetUrl + '&text=' + title
    }
  }

  function handleShareButtonClick (event) {
    
    var chosenPlatform = event.target.dataset.platform
    var shareTitle,
        shareDescription = ''

    if (chosenPlatform === 'facebook') {
      shareTitle = encodeURIComponent(document.title)

      var documentTitle = document.querySelector('meta[name="description"]')
      if (documentTitle && documentTitle.content) {
        shareDescription = documentTitle.content
      }
    } else if (chosenPlatform === 'sinaweibo') {
      shareTitle = encodeURIComponent(document.title)
    } else if (chosenPlatform === 'twitter') {
      shareTitle = encodeURIComponent(document.title)
    }

    var shareUrl = getShareUrl({
      facebookAppId: facebookAppId,
      title: shareTitle,
      description: shareDescription,
      platform: chosenPlatform,
      targetUrl: window.location.href
    })
    ga('send', 'event', 'social_button', 'click', chosenPlatform)
    window.open(shareUrl)
  }

  function handleWechatShareButtonClick () {
    var display
    ga('send', 'event', 'social_button', 'click', 'wechat')
  }

  function getQrcodeImgSrc (url) {

    var urlLen = url.length

    // Heuristic determination of how detailed the QR code should be
    var qrTypeNumber = Math.floor((urlLen - 40) / 20) + 4
    console.log('qrTypeNumber=', qrTypeNumber)
    const qrErrorCorrectLevel = 'M'

    try {
      var qr = qrcode(qrTypeNumber, qrErrorCorrectLevel)
      qr.addData(url)
      qr.make()
      var imgString = qr.createImgTag()
      var re = /src="([^"]*)"/i
      return re.exec(imgString)[1]
    } catch (error) {
      // Fallback if anything went wrong
      console.log(error)
      return wechatQrImage //FIXME: Add a default language
    }
  }

  // Attach click listeners on the social sharing buttons

  var socialShareButtons = document.getElementsByClassName('btnSocialShare')
  var i, btn;

  for (i = 0; i < socialShareButtons.length; i += 1) {
    btn = socialShareButtons[i]
    if (btn.className.indexOf('Wechat') > -1) {
      // Wechat, use special handling
      btn.addEventListener('click', handleWechatShareButtonClick)  
    } else {
      // Otherwise, use normal handling
      btn.addEventListener('click', handleShareButtonClick)
    }
  } 

  // Compute and set WeChat QRCode
  var qrImg = document.getElementById('wechatQR')
  qrImg.src = getQrcodeImgSrc(window.location.href)

  // Toggle dipaly of QRCode
  var wechatShareButton = document.getElementsByClassName('btnWechatShare')[0]
  var wechatQRWrapper = document.getElementById('wechatQRWrapper')
  wechatShareButton.addEventListener('click', function (event) {
    if (wechatQRWrapper.style.display == 'none') {
      wechatQRWrapper.style.display = 'block' 
    } else {
      wechatQRWrapper.style.display = 'none'
    }
  })

})(window, window.document, window.qrcode)