const rtcopt = {
  iceServers: [{ urls: 'stun:stun.l.google.com:19302' }],
  iceTransportPolicy: 'all'
}

const waitVannilaIce = peer => {
  return new Promise(resolve => {
    peer.onicecandidate = ev => {
      if (!ev.candidate) {
        resolve()
      }
    }
  })
}

const handshake = async offer => {
  // 1. RTCPeerConnection を作成する
  const peer = new RTCPeerConnection(rtcopt)

  // 2. 相手から受け取ったオファーを登録する
  await peer.setRemoteDescription(offer)

  // 3. アンサーを作成する
  const answer = await peer.createAnswer()
  await peer.setLocalDescription(answer)
  await waitVannilaIce(peer)
  console.log(peer.localDescription.sdp)

  peer.ondatachannel = event => {
    const dc = event.channel
    dc.onmessage = ev => {
      console.log(`peer: [${ev.data}]`)
    }
  }

  return peer.localDescription
}

const connect = async onOpen => {
  // 1. RTCPeerConnection を作成する
  const peer = new RTCPeerConnection(rtcopt)

  // 2. データチャネルの設定をする
  const dataChannel = peer.createDataChannel('webrtc-coin')

  // 3. SDPというコネクション情報（オファー）を作成して相手に伝える
  const offer = await peer.createOffer()
  await peer.setLocalDescription(offer)
  await waitVannilaIce(peer)
  console.log(peer.localDescription.sdp)

  dataChannel.onopen = ev => onOpen(peer, dataChannel, ev)

  // 4. 相手側のSDP（アンサー）を受け取って登録する
  const answer = await handshake(peer.localDescription)
  await peer.setRemoteDescription(answer)
}

connect((peer, dataChannel, ev) => {
  // 接続してデータのやりとりができるようになったら呼び出される
  dataChannel.send('Hello, WebRTC P2P!')
})
