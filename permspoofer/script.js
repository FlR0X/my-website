document.addEventListener('DOMContentLoaded', () => {
    const blurOverlay = document.getElementById('blur-overlay');
    const audio = document.getElementById('background-music');

    blurOverlay.addEventListener('click', () => {
        audio.volume = 0.25;
        audio.play();
        blurOverlay.style.opacity = '0';
        blurOverlay.style.visibility = 'hidden';
    });

    const imageContainer = document.getElementById('image-container');
    const image = document.getElementById('image');

    document.addEventListener('mousemove', (e) => {
        const rect = imageContainer.getBoundingClientRect();
        const x = e.clientX - rect.left;
        const y = e.clientY - rect.top;

        const xPercent = (x / rect.width) * 2 - 1;
        const yPercent = (y / rect.height) * 2 - 1;

        image.style.transform = `rotateX(${yPercent * -10}deg) rotateY(${xPercent * 10}deg)`;
    });

    document.addEventListener('mouseleave', () => {
        image.style.transform = 'rotateX(0) rotateY(0)';
    });
});
