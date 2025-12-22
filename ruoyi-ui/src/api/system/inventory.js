import request from '@/utils/request'

// 查询教材库存列表
export function listInventory(query) {
  return request({
    url: '/system/inventory/list',
    method: 'get',
    params: query
  })
}

// 查询教材库存详细
export function getInventory(inventoryId) {
  return request({
    url: '/system/inventory/' + inventoryId,
    method: 'get'
  })
}

// 新增教材库存
export function addInventory(data) {
  return request({
    url: '/system/inventory',
    method: 'post',
    data: data
  })
}

// 修改教材库存
export function updateInventory(data) {
  return request({
    url: '/system/inventory',
    method: 'put',
    data: data
  })
}

// 删除教材库存
export function delInventory(inventoryId) {
  return request({
    url: '/system/inventory/' + inventoryId,
    method: 'delete'
  })
}
