export const itemsPerPage = process.env.ITEMS_PER_PAGE || 10

const envApiUrl = process.env.VUE_APP_API_URL || `${window.location.protocol}//${window.location.host}/api`

export const apiUrl = envApiUrl
