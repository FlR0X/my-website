var song = document.getElementById("song"); 
document.getElementById("video").setAttribute("autoplay", "autoplay");

song.volume = 0.25; 

function start() {
    document.getElementById("start").style.display = "none";
    document.getElementById("content").style.display = "block";
    song.play(); 
}
