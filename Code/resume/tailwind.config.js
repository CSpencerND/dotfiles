module.exports = {
    content: ["./src/**/*.{html,js}"],
    darkMode: "class",
    theme: {
        aspectRatio: {
            auto: "auto",
            square: "1 / 1",
            video: "16 / 9",
            paper: "17 / 22",
            1: "1",
            2: "2",
            3: "3",
            4: "4",
            5: "5",
            6: "6",
            7: "7",
            8: "8",
            9: "9",
            10: "10",
            11: "11",
            12: "12",
            13: "13",
            14: "14",
            15: "15",
            16: "16",
        },
        screens: {
            // max-width breakpoints
            "max-2xl": { max: "1535px" },
            // => @media (max-width: 1535px) { ... }

            "max-xl": { max: "1279px" },
            // => @media (max-width: 1279px) { ... }

            "max-lg": { max: "1023px" },
            // => @media (max-width: 1023px) { ... }

            "max-md": { max: "767px" },
            // => @media (max-width: 767px) { ... }

            "max-sm": { max: "639px" },
            // => @media (max-width: 639px) { ... }

            // min-width breakpoints
            sm: "640px",
            // => @media (min-width: 640px) { ... }

            md: "768px",
            // => @media (min-width: 768px) { ... }

            lg: "1024px",
            // => @media (min-width: 1024px) { ... }

            xl: "1280px",
            // => @media (min-width: 1280px) { ... }

            "2xl": "1536px",
            // => @media (min-width: 1536px) { ... }
        },
        extend: {
            colors: {
                "drac-hard": "hsl(231, 15%, 12%)",
                "drac-soft": "hsl(231, 15%, 18%)",
                "drac-hl": "hsl(232, 14%, 31%)",
                "drac-fg": "hsl(60, 30%, 96%)",
                "drac-magenta": "hsl(326, 100%, 74%)",
                "drac-purple": "hsl(265, 89%, 78%)",
                "drac-blue": "hsl(225, 27%, 51%)",
                "drac-cyan": "hsl(191, 97%, 77%)",
                "drac-green": "hsl(135, 94%, 65%)",
                "drac-yellow": "hsl(65, 92%, 76%)",
                "drac-orange": "hsl(31, 100%, 71%)",
                "drac-red": "hsl(0, 100%, 67%)",
            },
        },
    },
    plugins: [require("@tailwindcss/aspect-ratio")],
}
