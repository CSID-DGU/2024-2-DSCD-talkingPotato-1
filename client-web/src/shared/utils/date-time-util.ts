export const convertDateToString = (date: Date): string => {
    const year = date.getFullYear()
    const month = String(date.getMonth() + 1).padStart(2, '0')
    const day = String(date.getDate()).padStart(2, '0')

    return `${year}-${month}-${day}`
}

export const convertStringToDate = (date: string): Date => {
    return new Date(date)
};

export const convertDateToKoreanString = (date: Date): string => {
    const year = date.getFullYear()
    const month = String(date.getMonth() + 1).padStart(2, '0')
    const day = String(date.getDate()).padStart(2, '0')

    return `${year}년 ${parseInt(month)}월 ${parseInt(day)}일`
}

export const convertStringToTime = (time: string): number => {
    const [hour, minute] = time.split(':').map((time) => parseInt(time))
    return hour * 60 + minute
}

export const calculateTime = (date: Date): string => {
    const milliSeconds = new Date().getTime() - date.getTime();

    const seconds = milliSeconds / 1000;

    if (seconds < 60) {
        return `방금 전`
    }

    const minutes = seconds / 60;

    if (minutes < 60) {
        return `${Math.floor(minutes)}분 전`
    }

    const hours = minutes / 60;

    if (hours < 24) {
        return `${Math.floor(hours)}시간 전`
    }

    const days = hours / 24;

    if (days < 7) {
        return `${Math.floor(days)}일 전`
    }

    const weeks = days / 7;

    if (weeks < 5) {
        return `${Math.floor(weeks)}주 전`
    }

    const months = days / 30;

    if (months < 12) {
        return `${Math.floor(months)}개월 전`
    }

    const years = months / 12;

    return `${Math.floor(years)}년 전`
}

export default {
    convertDateToString,
    convertStringToDate,
    convertDateToKoreanString,
    convertStringToTime,
    calculateTime
}