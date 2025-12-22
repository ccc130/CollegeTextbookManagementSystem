import request from '@/utils/request'

// 查询出入库日志列表
export function listLogs(query) {
  return request({
    url: '/system/logs/list',
    method: 'get',
    params: query
  })
}

// 查询出入库日志详细
export function getLogs(logId) {
  return request({
    url: '/system/logs/' + logId,
    method: 'get'
  })
}

// 新增出入库日志
export function addLogs(data) {
  return request({
    url: '/system/logs',
    method: 'post',
    data: data
  })
}

// 修改出入库日志
export function updateLogs(data) {
  return request({
    url: '/system/logs',
    method: 'put',
    data: data
  })
}

// 删除出入库日志
export function delLogs(logId) {
  return request({
    url: '/system/logs/' + logId,
    method: 'delete'
  })
}
