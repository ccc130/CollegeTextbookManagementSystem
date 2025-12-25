import request from '@/utils/request'

// 查询课程管理列表
export function listCourse(query) {
  return request({
    url: '/textbook/course/list',
    method: 'get',
    params: query
  })
}

// 查询课程管理详细
export function getCourse(CourseID) {
  return request({
    url: '/textbook/course/' + CourseID,
    method: 'get'
  })
}

// 新增课程管理
export function addCourse(data) {
  return request({
    url: '/textbook/course',
    method: 'post',
    data: data
  })
}

// 修改课程管理
export function updateCourse(data) {
  return request({
    url: '/textbook/course',
    method: 'put',
    data: data
  })
}

// 删除课程管理
export function delCourse(CourseID) {
  return request({
    url: '/textbook/course/' + CourseID,
    method: 'delete'
  })
}
