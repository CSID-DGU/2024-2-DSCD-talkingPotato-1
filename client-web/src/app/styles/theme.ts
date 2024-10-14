const colorSystem = {

    /**
     * Primary Color
     */
    primary: {
        100: "#032A28",
        200: "#05332C",
        300: "#083F31",
        400: "#0C4B35",
        500: "#115838",
        600: "#3D9A67",
        700: "#69CC8C",
        800: "#A1EEB4",
        900: "#CEF6D4",
    },

    /**
     * Secondary Color
     */
    secondary: {
        100: "#014845",
        200: "#02574B",
        300: "#036C53",
        400: "#058157",
        500: "#079658",
        600: "#36C076",
        700: "#5FDF8E",
        800: "#A1EEB4",
        900: "#CAF9D2",
    },

    /**
     * Neutral Color
     */
    neutral: {
        100: "#1C1C4F",
        200: "#2E2E5F",
        300: "#494976",
        400: "#6A6A8D",
        500: "#9292A5",
        600: "#B7B7C9",
        700: "#D4D4E3",
        800: "#EAEAF6",
        900: "#F5F5FF",
    },

    /**
     * Red Color
     */
    red: {
        100: "#7A082D",
        200: "#930D2E",
        300: "#B7152F",
        400: "#DB1F2C",
        500: "#FF2E2B",
        600: "#FF6F60",
        700: "#FF977F",
        800: "#FFC1AA",
        900: "#FFE3D4",
    },

    /**
     * Yellow Color
     */
    yellow: {
        100: "#643500",
        200: "#794400",
        300: "#965A01",
        400: "#B37201",
        500: "#D18C02",
        600: "#E3B03A",
        700: "#F1CB61",
        800: "#FAE397",
        900: "#FCF2CA",
    },

    /**
     * Blue Color
     */
    blue: {
        100: "#102670",
        200: "#002459",
        300: "#01336F",
        400: "#024585",
        500: "#03599B",
        600: "#338CC3",
        700: "#5CB6E1",
        800: "#94DBF5",
        900: "#C8EFFA",
    },

    /**
     * White Color
     */
    white: "#FFFFFF",

    /**
     * Black Color
     */
    black: "#000000",
}

const fontSystem = {
    he: {
        fontSize: "60px",
        lineHeight: "60px",
        fontWeight: "700",
        fontFamily: "Pretendard"
    },
    h0: {
        fontSize: "3rem",
        lineHeight: "3.75rem",
        fontWeight: "700",
        fontFamily: "Pretendard"
    },
    h1: {
        fontSize: "1.5rem",
        lineHeight: "1.875rem",
        fontWeight: "700",
        fontFamily: "Pretendard"
    },
    h2: {
        fontSize: "1.375rem",
        lineHeight: "1.719rem",
        fontWeight: "700",
        fontFamily: "Pretendard"
    },
    h3: {
        fontSize: "1.25rem",
        lineHeight: "1.563rem",
        fontWeight: "700",
        fontFamily: "Pretendard"
    },
    h4: {
        fontSize: "1.125rem",
        lineHeight: "1.406rem",
        fontWeight: "700",
        fontFamily: "Pretendard"
    },
    h5: {
        fontSize: "1rem",
        lineHeight: "1.25rem",
        fontWeight: "700",
        fontFamily: "Pretendard"
    },
    h6: {
        fontSize: "1rem",
        lineHeight: "1.25rem",
        fontWeight: "500",
        fontFamily: "Pretendard"
    },
    sub1: {
        fontSize: "0.875rem",
        lineHeight: "1.25rem",
        fontWeight: "700",
        fontFamily: "Pretendard"
    },
    sub2: {
        fontSize: "0.875rem",
        lineHeight: "1.25rem",
        fontWeight: "500",
        fontFamily: "Pretendard"
    },
    sub3: {
        fontSize: "0.75rem",
        lineHeight: "1.25rem",
        fontWeight: "500",
        fontFamily: "Pretendard"
    },
}

const theme = {
    colorSystem,
    fontSystem,
};

export default theme;

export type Theme = typeof theme;