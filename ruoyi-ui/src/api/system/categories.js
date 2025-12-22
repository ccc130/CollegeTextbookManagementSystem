import request from '@/utils/request'

// 查询教材类型列表
export function listCategories(query) {
  return request({
    url: '/system/categories/list',
    method: 'get',
    params: query
  })
}

// 查询教材类型详细
export function getCategories(categoryId) {
  return request({
    url: '/system/categories/' + categoryId,
    method: 'get'
  })
}

// 新增教材类型
export function addCategories(data) {
  return request({
    url: '/system/categories',
    method: 'post',
    data: data
  })
}

// 修改教材类型
export function updateCategories(data) {
  return request({
    url: '/system/categories',
    method: 'put',
    data: data
  })
}

// 删除教材类型
export function delCategories(categoryId) {
  return request({
    url: '/system/categories/' + categoryId,
    method: 'delete'
  })
}
