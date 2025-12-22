import request from '@/utils/request'

// 查询出版社信息列表
export function listPublishers(query) {
  return request({
    url: '/system/publishers/list',
    method: 'get',
    params: query
  })
}

// 查询出版社信息详细
export function getPublishers(publisherId) {
  return request({
    url: '/system/publishers/' + publisherId,
    method: 'get'
  })
}

// 新增出版社信息
export function addPublishers(data) {
  return request({
    url: '/system/publishers',
    method: 'post',
    data: data
  })
}

// 修改出版社信息
export function updatePublishers(data) {
  return request({
    url: '/system/publishers',
    method: 'put',
    data: data
  })
}

// 删除出版社信息
export function delPublishers(publisherId) {
  return request({
    url: '/system/publishers/' + publisherId,
    method: 'delete'
  })
}
