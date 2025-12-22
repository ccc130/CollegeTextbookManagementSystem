import request from '@/utils/request'

// 查询征订申请列表
export function listRequests(query) {
  return request({
    url: '/system/requests/list',
    method: 'get',
    params: query
  })
}

// 查询征订申请详细
export function getRequests(requestId) {
  return request({
    url: '/system/requests/' + requestId,
    method: 'get'
  })
}

// 新增征订申请
export function addRequests(data) {
  return request({
    url: '/system/requests',
    method: 'post',
    data: data
  })
}

// 修改征订申请
export function updateRequests(data) {
  return request({
    url: '/system/requests',
    method: 'put',
    data: data
  })
}

// 删除征订申请
export function delRequests(requestId) {
  return request({
    url: '/system/requests/' + requestId,
    method: 'delete'
  })
}
