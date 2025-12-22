import request from '@/utils/request'

// 查询学生列表
export function listStu(query) {
  return request({
    url: '/student/stu/list',
    method: 'get',
    params: query
  })
}

// 查询学生详细
export function getStu(id) {
  return request({
    url: '/student/stu/' + id,
    method: 'get'
  })
}

// 新增学生
export function addStu(data) {
  return request({
    url: '/student/stu',
    method: 'post',
    data: data
  })
}

// 修改学生
export function updateStu(data) {
  return request({
    url: '/student/stu',
    method: 'put',
    data: data
  })
}

// 删除学生
export function delStu(id) {
  return request({
    url: '/student/stu/' + id,
    method: 'delete'
  })
}
