import request from '@/utils/request'

// 查询教学计划列表
export function listTeachingplan(query) {
  return request({
    url: '/textbook/teachingplan/list',
    method: 'get',
    params: query
  })
}

// 查询教学计划详细
export function getTeachingplan(PlanID) {
  return request({
    url: '/textbook/teachingplan/' + PlanID,
    method: 'get'
  })
}

// 新增教学计划
export function addTeachingplan(data) {
  return request({
    url: '/textbook/teachingplan',
    method: 'post',
    data: data
  })
}

// 修改教学计划
export function updateTeachingplan(data) {
  return request({
    url: '/textbook/teachingplan',
    method: 'put',
    data: data
  })
}

// 删除教学计划
export function delTeachingplan(PlanID) {
  return request({
    url: '/textbook/teachingplan/' + PlanID,
    method: 'delete'
  })
}
