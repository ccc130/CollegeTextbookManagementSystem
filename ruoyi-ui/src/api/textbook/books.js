import request from '@/utils/request'

// 查询教材信息列表
export function listBooks(query) {
  return request({
    url: '/textbook/books/list',
    method: 'get',
    params: query
  })
}

// 查询教材信息详细
export function getBooks(textbookId) {
  return request({
    url: '/textbook/books/' + textbookId,
    method: 'get'
  })
}

// 新增教材信息
export function addBooks(data) {
  return request({
    url: '/textbook/books',
    method: 'post',
    data: data
  })
}

// 修改教材信息
export function updateBooks(data) {
  return request({
    url: '/textbook/books',
    method: 'put',
    data: data
  })
}

// 删除教材信息
export function delBooks(textbookId) {
  return request({
    url: '/textbook/books/' + textbookId,
    method: 'delete'
  })
}
