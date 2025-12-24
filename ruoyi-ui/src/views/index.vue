<template>
  <div class="dashboard-container">
    <div class="dashboard-editor-container">
      <el-row :gutter="20">
        <el-col :span="24">
          <div class="grid-content bg-purple">
            <h2>教材管理系统 - 数据统计</h2>
          </div>
        </el-col>
      </el-row>
      
      <!-- 统计卡片 -->
      <el-row :gutter="20" class="mt-20">
        <el-col :span="6" v-if="showAllStats || hasTextbookPermission">
          <el-card class="stat-card">
            <div class="stat-item">
              <div class="stat-icon bg-blue">
                <i class="el-icon-notebook"></i>
              </div>
              <div class="stat-text">
                <div class="stat-number">{{ textbookStats.totalTextbooks }}</div>
                <div class="stat-label">教材总数</div>
              </div>
            </div>
          </el-card>
        </el-col>
        <el-col :span="6" v-if="showAllStats || hasInventoryPermission">
          <el-card class="stat-card">
            <div class="stat-item">
              <div class="stat-icon bg-green">
                <i class="el-icon-box"></i>
              </div>
              <div class="stat-text">
                <div class="stat-number">{{ inventoryStats.totalInventory }}</div>
                <div class="stat-label">库存总量</div>
              </div>
            </div>
          </el-card>
        </el-col>
        <el-col :span="6" v-if="showAllStats || hasRequestPermission">
          <el-card class="stat-card">
            <div class="stat-item">
              <div class="stat-icon bg-orange">
                <i class="el-icon-document"></i>
              </div>
              <div class="stat-text">
                <div class="stat-number">{{ requestStats.totalRequests }}</div>
                <div class="stat-label">征订申请</div>
              </div>
            </div>
          </el-card>
        </el-col>
        <el-col :span="6" v-if="showAllStats || hasLogPermission">
          <el-card class="stat-card">
            <div class="stat-item">
              <div class="stat-icon bg-red">
                <i class="el-icon-s-order"></i>
              </div>
              <div class="stat-text">
                <div class="stat-number">{{ logStats.totalLogs }}</div>
                <div class="stat-label">操作日志</div>
              </div>
            </div>
          </el-card>
        </el-col>
      </el-row>

      <!-- 图表区域 - 系统管理员和教材管理员 -->
      <template v-if="showAllStats">
        <el-row :gutter="20" class="mt-20">
          <el-col :span="14">
            <el-card class="chart-card">
              <template #header>
                <span class="chart-title">教材库存分布</span>
              </template>
              <div id="inventoryChart" style="height: 400px;"></div>
            </el-card>
          </el-col>
          <el-col :span="10">
            <el-card class="chart-card">
              <template #header>
                <span class="chart-title">征订申请状态</span>
              </template>
              <div id="statusChart" style="height: 400px;"></div>
            </el-card>
          </el-col>
        </el-row>

        <el-row :gutter="20" class="mt-20">
          <el-col :span="12">
            <el-card class="chart-card">
              <template #header>
                <span class="chart-title">教材类型分布</span>
              </template>
              <div id="categoryChart" style="height: 300px;"></div>
            </el-card>
          </el-col>
          <el-col :span="12">
            <el-card class="chart-card">
              <template #header>
                <span class="chart-title">征订申请趋势</span>
              </template>
              <div id="trendChart" style="height: 300px;"></div>
            </el-card>
          </el-col>
        </el-row>
      </template>

      <!-- 教材管理员视图 -->
      <template v-else-if="hasInventoryPermission">
        <el-row :gutter="20" class="mt-20">
          <el-col :span="14">
            <el-card class="chart-card">
              <template #header>
                <span class="chart-title">教材库存分布</span>
              </template>
              <div id="inventoryChart" style="height: 400px;"></div>
            </el-card>
          </el-col>
          <el-col :span="10">
            <el-card class="chart-card">
              <template #header>
                <span class="chart-title">征订申请状态</span>
              </template>
              <div id="statusChart" style="height: 400px;"></div>
            </el-card>
          </el-col>
        </el-row>

        <el-row :gutter="20" class="mt-20">
          <el-col :span="24">
            <el-card class="chart-card">
              <template #header>
                <span class="chart-title">教材类型分布</span>
              </template>
              <div id="categoryChart" style="height: 300px;"></div>
            </el-card>
          </el-col>
        </el-row>
      </template>

      <!-- 学院管理员视图 -->
      <template v-else-if="hasRequestPermission && !hasInventoryPermission">
        <el-row :gutter="20" class="mt-20">
          <el-col :span="24">
            <el-card class="chart-card">
              <template #header>
                <span class="chart-title">征订申请状态</span>
              </template>
              <div id="statusChart" style="height: 400px;"></div>
            </el-card>
          </el-col>
        </el-row>

        <el-row :gutter="20" class="mt-20">
          <el-col :span="24">
            <el-card class="chart-card">
              <template #header>
                <span class="chart-title">征订申请趋势</span>
              </template>
              <div id="trendChart" style="height: 300px;"></div>
            </el-card>
          </el-col>
        </el-row>
      </template>

      <!-- 任课教师视图 -->
      <template v-else-if="hasOwnRequestPermission">
        <el-row :gutter="20" class="mt-20">
          <el-col :span="24">
            <el-card class="chart-card">
              <template #header>
                <span class="chart-title">我的征订申请状态</span>
              </template>
              <div id="statusChart" style="height: 400px;"></div>
            </el-card>
          </el-col>
        </el-row>
      </template>
    </div>
  </div>
</template>

<script setup>
import { ref, onMounted, onUnmounted, nextTick, computed } from 'vue'
import { listBooks } from '@/api/textbook/books'
import { listInventory } from '@/api/system/inventory'
import { listRequests } from '@/api/system/requests'
import { listLogs } from '@/api/system/logs'
import { listCategories } from '@/api/system/categories'
import useUserStore from '@/store/modules/user'
import * as echarts from 'echarts'

// 用户权限存储
const userStore = useUserStore()

// 统计数据
const textbookStats = ref({ totalTextbooks: 0 })
const inventoryStats = ref({ totalInventory: 0 })
const requestStats = ref({ totalRequests: 0 })
const logStats = ref({ totalLogs: 0 })

// 图表实例
let inventoryChart = null
let statusChart = null
let categoryChart = null
let trendChart = null

// 计算权限
const hasTextbookPermission = computed(() => {
  return userStore.roles.includes('admin') || 
         userStore.permissions.includes('textbook:books:list')|| 
         userStore.permissions.includes('system:inventory:list')
})

const hasInventoryPermission = computed(() => {
  return userStore.roles.includes('admin') || 
         userStore.permissions.includes('system:inventory:list')
})

const hasRequestPermission = computed(() => {
  return userStore.roles.includes('admin') || 
         userStore.permissions.includes('system:requests:list')
})

const hasLogPermission = computed(() => {
  return userStore.roles.includes('admin') || 
         userStore.roles.includes('教材管理员') || 
         userStore.permissions.includes('system:logs:list')
})

const hasOwnRequestPermission = computed(() => {
  return userStore.roles.includes('任课教师') || 
         userStore.permissions.includes('system:requests:own')
})

const showAllStats = computed(() => {
  return userStore.roles.includes('admin') || userStore.roles.includes('教材管理员')
})

// 获取统计数据
async function fetchStatistics() {
  try {
    // 根据权限获取相应的统计数据
    if (hasTextbookPermission.value) {
      const textbookResponse = await listBooks({ pageSize: 1 })
      textbookStats.value.totalTextbooks = textbookResponse.total || 0
    }

    if (hasInventoryPermission.value) {
      const inventoryResponse = await listInventory({ pageSize: 10000 })
      inventoryStats.value.totalInventory = inventoryResponse.rows.reduce((sum, item) => sum + (item.availableQuantity || 0), 0)
    }

    // 根据权限获取征订申请数据
    let requestParams = { pageSize: 1 }
    if (!showAllStats.value && !hasRequestPermission.value && hasOwnRequestPermission.value) {
      // 任课教师只能查看自己的申请
      requestParams.teacherId = userStore.id
    }
    
    const requestResponse = await listRequests(requestParams)
    requestStats.value.totalRequests = requestResponse.total || 0

    if (hasLogPermission.value) {
      const logResponse = await listLogs({ pageSize: 1 })
      logStats.value.totalLogs = logResponse.total || 0
    }

    // 加载图表数据
    await loadChartsData()
  } catch (error) {
    console.error('获取统计数据失败:', error)
  }
}

// 加载图表数据
async function loadChartsData() {
  try {
    // 根据权限获取相应的图表数据
    let textbooksRes = null
    let inventoryRes = null
    let requestsRes = null
    let categoriesRes = null

    if (hasTextbookPermission.value) {
      textbooksRes = await listBooks({ pageSize: 1000 })
    }

    if (hasInventoryPermission.value) {
      inventoryRes = await listInventory({ pageSize: 1000 })
    }

    // 获取征订申请数据 - 根据权限过滤
    let requestParams = { pageSize: 1000 }
    if (!showAllStats.value && !hasRequestPermission.value && hasOwnRequestPermission.value) {
      // 任课教师只能查看自己的申请
      requestParams.teacherId = userStore.id
    }
    requestsRes = await listRequests(requestParams)

    if (showAllStats.value) {
      categoriesRes = await listCategories({ pageSize: 1000 })
    }

    // 库存分布图表 - 仅对有库存权限的用户显示
    if (hasInventoryPermission.value && textbooksRes && inventoryRes) {
      // 合并教材和库存数据
      const textbooksWithInventory = textbooksRes.rows.map(textbook => {
        const inventory = inventoryRes.rows.find(inv => inv.textbookId === textbook.textbookId)
        return {
          ...textbook,
          availableQuantity: inventory ? inventory.availableQuantity : 0
        }
      })

      // 库存分布图表 - 显示库存量最高的前10本教材
      const topInventoryTextbooks = textbooksWithInventory
        .sort((a, b) => b.availableQuantity - a.availableQuantity)
        .slice(0, 10)
      
      if (inventoryChart) {
        inventoryChart.setOption({
          title: {
            text: '教材库存分布（前10）',
            left: 'center'
          },
          tooltip: {
            trigger: 'axis',
            axisPointer: {
              type: 'shadow'
            }
          },
          xAxis: {
            type: 'category',
            data: topInventoryTextbooks.map(item => item.title.substring(0, 10) + (item.title.length > 10 ? '...' : ''))
          },
          yAxis: {
            type: 'value',
            name: '库存数量'
          },
          series: [{
            data: topInventoryTextbooks.map(item => item.availableQuantity),
            type: 'bar',
            itemStyle: {
              color: '#409EFF'
            }
          }]
        })
      }
    }

    // 征订申请状态图表 - 所有有权限的用户都可以看到
    if (requestsRes) {
      const statusCount = requestsRes.rows.reduce((acc, req) => {
        acc[req.status] = (acc[req.status] || 0) + 1
        return acc
      }, {})
      
      const statusOptions = [
        { value: statusCount['0'] || 0, name: '待审核' },
        { value: statusCount['1'] || 0, name: '已通过' },
        { value: statusCount['2'] || 0, name: '已拒绝' }
      ]
      
      if (statusChart) {
        statusChart.setOption({
          title: {
            text: '征订申请状态',
            left: 'center'
          },
          tooltip: {
            trigger: 'item'
          },
          legend: {
            orient: 'vertical',
            left: 'left'
          },
          series: [{
            name: '申请状态',
            type: 'pie',
            radius: '50%',
            data: statusOptions,
            emphasis: {
              itemStyle: {
                shadowBlur: 10,
                shadowOffsetX: 0,
                shadowColor: 'rgba(0, 0, 0, 0.5)'
              }
            }
          }]
        })
      }
    }

    // 教材类型分布图表 - 仅对系统管理员和教材管理员显示
    if (showAllStats.value && categoriesRes && textbooksRes) {
      const categoryMap = {}
      categoriesRes.rows.forEach(cat => {
        categoryMap[cat.categoryId] = cat.categoryName
      })
      
      const categoryCount = textbooksRes.rows.reduce((acc, book) => {
        const categoryName = categoryMap[book.categoryId] || '未分类'
        acc[categoryName] = (acc[categoryName] || 0) + 1
        return acc
      }, {})
      
      const categoryData = Object.keys(categoryCount).map(key => ({
        value: categoryCount[key],
        name: key
      }))
      
      if (categoryChart) {
        categoryChart.setOption({
          title: {
            text: '教材类型分布',
            left: 'center'
          },
          tooltip: {
            trigger: 'item'
          },
          legend: {
            orient: 'vertical',
            left: 'left'
          },
          series: [{
            name: '教材类型',
            type: 'pie',
            radius: '50%',
            data: categoryData,
            emphasis: {
              itemStyle: {
                shadowBlur: 10,
                shadowOffsetX: 0,
                shadowColor: 'rgba(0, 0, 0, 0.5)'
              }
            }
          }]
        })
      }
    }

    // 征订申请趋势图表 - 仅对系统管理员、教材管理员和学院管理员显示
    if ((showAllStats.value || hasRequestPermission.value) && requestsRes) {
      const requestByMonth = {}
      requestsRes.rows.forEach(req => {
        const date = new Date(req.submittedAt)
        const monthKey = `${date.getFullYear()}-${String(date.getMonth() + 1).padStart(2, '0')}`
        requestByMonth[monthKey] = (requestByMonth[monthKey] || 0) + 1
      })
      
      const months = Object.keys(requestByMonth).sort()
      const counts = months.map(month => requestByMonth[month])
      
      if (trendChart) {
        trendChart.setOption({
          title: {
            text: '征订申请趋势',
            left: 'center'
          },
          tooltip: {
            trigger: 'axis'
          },
          xAxis: {
            type: 'category',
            data: months
          },
          yAxis: {
            type: 'value'
          },
          series: [{
            data: counts,
            type: 'line',
            smooth: true,
            itemStyle: {
              color: '#67C23A'
            }
          }]
        })
      }
    }
  } catch (error) {
    console.error('加载图表数据失败:', error)
  }
}

// 初始化图表
function initCharts() {
  nextTick(() => {
    // 库存分布图表 - 仅对有库存权限的用户初始化
    if (hasInventoryPermission.value) {
      const inventoryChartDom = document.getElementById('inventoryChart')
      if (inventoryChartDom) {
        inventoryChart = echarts.init(inventoryChartDom)
      }
    }

    // 状态图表 - 所有有权限的用户都需要
    const statusChartDom = document.getElementById('statusChart')
    if (statusChartDom) {
      statusChart = echarts.init(statusChartDom)
    }

    // 类型分布图表 - 仅对系统管理员和教材管理员初始化
    if (showAllStats.value) {
      const categoryChartDom = document.getElementById('categoryChart')
      if (categoryChartDom) {
        categoryChart = echarts.init(categoryChartDom)
      }
    }

    // 趋势图表 - 仅对系统管理员、教材管理员和学院管理员初始化
    if (showAllStats.value || hasRequestPermission.value) {
      const trendChartDom = document.getElementById('trendChart')
      if (trendChartDom) {
        trendChart = echarts.init(trendChartDom)
      }
    }

    // 加载数据
    loadChartsData()
  })
}

// 组件挂载时获取数据
onMounted(() => {
  fetchStatistics()
  initCharts()
  
  // 监听窗口大小变化
  window.addEventListener('resize', () => {
    if (inventoryChart) inventoryChart.resize()
    if (statusChart) statusChart.resize()
    if (categoryChart) categoryChart.resize()
    if (trendChart) trendChart.resize()
  })
})

// 组件卸载时清理
onUnmounted(() => {
  if (inventoryChart) inventoryChart.dispose()
  if (statusChart) statusChart.dispose()
  if (categoryChart) categoryChart.dispose()
  if (trendChart) trendChart.dispose()
  
  window.removeEventListener('resize', () => {})
})
</script>

<style scoped>
.dashboard-container {
  padding: 20px;
  background-color: #f0f2f5;
  min-height: 100vh;
}

.mt-20 {
  margin-top: 20px;
}

.grid-content {
  border-radius: 4px;
  min-height: 36px;
  display: flex;
  align-items: center;
  padding-left: 20px;
}

.stat-card {
  border-radius: 8px;
  box-shadow: 0 2px 12px 0 rgba(0, 0, 0, 0.1);
}

.stat-item {
  display: flex;
  align-items: center;
}

.stat-icon {
  width: 60px;
  height: 60px;
  border-radius: 8px;
  display: flex;
  align-items: center;
  justify-content: center;
  margin-right: 15px;
}

.stat-icon i {
  font-size: 24px;
  color: white;
}

.stat-text {
  flex: 1;
}

.stat-number {
  font-size: 24px;
  font-weight: bold;
  color: #303133;
}

.stat-label {
  font-size: 14px;
  color: #909399;
  margin-top: 5px;
}

.bg-blue {
  background-color: #409EFF;
}

.bg-green {
  background-color: #67C23A;
}

.bg-orange {
  background-color: #E6A23C;
}

.bg-red {
  background-color: #F56C6C;
}

.chart-card {
  border-radius: 8px;
  box-shadow: 0 2px 12px 0 rgba(0, 0, 0, 0.1);
}

.chart-title {
  font-weight: bold;
  font-size: 16px;
}
</style>