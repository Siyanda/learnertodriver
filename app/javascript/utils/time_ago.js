// app/javascript/utils/time_ago.js
import dayjs from 'dayjs'
import relativeTime from 'dayjs/plugin/relativeTime'

dayjs.extend(relativeTime)

export function getRelativeTimeString(isoTime) {
  return dayjs(isoTime).fromNow()
}

export function getNextInterval(ageInSeconds) {
  if (ageInSeconds < 60) {
    return 1000
  } else if (ageInSeconds < 3600) {
    return 60 * 1000
  } else if (ageInSeconds < 86400) {
    return 60 * 60 * 1000
  } else {
    return null
  }
}
