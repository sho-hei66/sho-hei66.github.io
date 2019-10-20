'use strict';

let localStream = null;
let peer = null;
let existingCall = null;

peer = new Peer({
    key: '36d58092-aaa0-466d-8fa6-1ae3fbd0e57e',
    debug: 3
});

peer.on('open', function(){
    $('#my-id').text(peer.id);
});

// peer.on('error', function(err){
//     alert(err.message);
// });


// peer.on('close', function(){
// });

// peer.on('disconnected', function(){
// });
