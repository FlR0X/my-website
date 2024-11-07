document.addEventListener('DOMContentLoaded', function() {
    const overlay = document.getElementById('overlay');
    const content = document.getElementById('content');
    const quoteElement = document.getElementById('quote');
    const mainTextElement = document.getElementById('main-text');
    const notification = document.getElementById('notification');
    const discordLink = document.getElementById('discord-link');
    const backgroundMusic = document.getElementById('background-music');

    backgroundMusic.loop = true; // Make the song loop

    const quotes = [
        "' If the most important people in this world cheat, why shouldn't I? '",
        "' I Love you Mia '",
        "' AntiSocial 4 Lyfe '",
        "' Paster '",
        "' Firox 4 Ever. '",
        "' Non Proffesional Fraudstar. '"
    ];
    let quoteIndex = 0;
    
    overlay.addEventListener('click', () => {
        backgroundMusic.volume = 0.05;
        backgroundMusic.play();
        overlay.style.opacity = '0';
        setTimeout(() => {
            overlay.style.display = 'none';
            content.style.display = 'block';
        }, 500);
    });

    function typeQuote() {
        const quote = quotes[quoteIndex];
        let charIndex = 1;  // Start with the second character since first is always shown
        quoteElement.innerHTML = quote.charAt(0); // Initialize with the first character

        function typeChar() {
            if (charIndex < quote.length) {
                quoteElement.innerHTML += quote.charAt(charIndex);
                charIndex++;
                setTimeout(typeChar, 70);
            } else {
                setTimeout(deleteQuote, 2000);
            }
        }

        function deleteQuote() {
            if (charIndex > 1) { // Ensure at least the first character is kept
                quoteElement.innerHTML = quoteElement.innerHTML.slice(0, -1);
                charIndex--;
                setTimeout(deleteQuote, 50);
            } else {
                quoteIndex = (quoteIndex + 1) % quotes.length;
                setTimeout(typeQuote, 1000);
            }
        }

        typeChar();
    }

    typeQuote();

    discordLink.addEventListener('click', (e) => {
        e.preventDefault();
        navigator.clipboard.writeText('gworld.').then(() => {
            notification.style.display = 'block';
            setTimeout(() => {
                notification.style.opacity = '1';
            }, 10);
            setTimeout(() => {
                notification.style.opacity = '0';
                setTimeout(() => {
                    notification.style.display = 'none';
                }, 500);
            }, 2000);
        });
    });

    function glitchText() {
        let originalText = "[ F1R0X ]";
        let glitchVariants = ["[ F1R0X ]", "[ FIROX ]", "[ F1ROX ]", "[ F1R0X ]", "[ F1ROX ]"];
        let glitchIndex = 0;

        function updateText() {
            const text = glitchVariants[glitchIndex];
            mainTextElement.firstChild.textContent = text;
            document.title = text; // Update the title with the glitched text
            glitchIndex = (glitchIndex + 1) % glitchVariants.length;
            setTimeout(updateText, 300); // Adjust the timing for the glitch effect
        }

        updateText();
    }

    glitchText();
});
