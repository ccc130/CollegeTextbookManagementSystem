<template>
  <div class="app-container">
    <div class="dashboard-editor-container">
      <el-row :gutter="20">
        <el-col :span="24">
          <div class="grid-content bg-purple">
            <h2>教材管理系统</h2>
            <p>全面的教材管理解决方案，支持从教学计划到库存管理的全流程</p>
          </div>
        </el-col>
      </el-row>
      
      <!-- 功能模块卡片 -->
      <el-row :gutter="20" class="mt-20">
        <el-col :span="6">
          <el-card class="module-card" @click="$router.push('/textbook/teachingplan')">
            <div class="module-item">
              <div class="module-icon bg-blue">
                <i class="el-icon-school"></i>
              </div>
              <div class="module-text">
                <div class="module-title">教学计划</div>
                <div class="module-desc">安排学期教学任务</div>
              </div>
            </div>
          </el-card>
        </el-col>
        <el-col :span="6">
          <el-card class="module-card" @click="$router.push('/textbook/books')">
            <div class="module-item">
              <div class="module-icon bg-green">
                <i class="el-icon-notebook"></i>
              </div>
              <div class="module-text">
                <div class="module-title">教材管理</div>
                <div class="module-desc">管理教材信息</div>
              </div>
            </div>
          </el-card>
        </el-col>
        <el-col :span="6">
          <el-card class="module-card" @click="$router.push('/system/requests')">
            <div class="module-item">
              <div class="module-icon bg-orange">
                <i class="el-icon-document-add"></i>
              </div>
              <div class="module-text">
                <div class="module-title">征订申请</div>
                <div class="module-desc">申请教材征订</div>
              </div>
            </div>
          </el-card>
        </el-col>
        <el-col :span="6">
          <el-card class="module-card" @click="$router.push('/system/inventory')">
            <div class="module-item">
              <div class="module-icon bg-purple">
                <i class="el-icon-box"></i>
              </div>
              <div class="module-text">
                <div class="module-title">库存管理</div>
                <div class="module-desc">管理教材库存</div>
              </div>
            </div>
          </el-card>
        </el-col>
      </el-row>
      
      <el-row :gutter="20" class="mt-20">
        <el-col :span="6">
          <el-card class="module-card" @click="$router.push('/system/logs')">
            <div class="module-item">
              <div class="module-icon bg-red">
                <i class="el-icon-document"></i>
              </div>
              <div class="module-text">
                <div class="module-title">出入库记录</div>
                <div class="module-desc">记录出入库信息</div>
              </div>
            </div>
          </el-card>
        </el-col>
        <el-col :span="6">
          <el-card class="module-card" @click="$router.push('/system/returns')">
            <div class="module-item">
              <div class="module-icon bg-cyan">
                <i class="el-icon-refresh-left"></i>
              </div>
              <div class="module-text">
                <div class="module-title">教材退库</div>
                <div class="module-desc">处理教材退回</div>
              </div>
            </div>
          </el-card>
        </el-col>
        <el-col :span="6">
          <el-card class="module-card" @click="$router.push('/textbook/course')">
            <div class="module-item">
              <div class="module-icon bg-teal">
                <i class="el-icon-collection"></i>
              </div>
              <div class="module-text">
                <div class="module-title">课程管理</div>
                <div class="module-desc">管理课程信息</div>
              </div>
            </div>
          </el-card>
        </el-col>
        <el-col :span="6">
          <el-card class="module-card" @click="$router.push('/system/categories')">
            <div class="module-item">
              <div class="module-icon bg-indigo">
                <i class="el-icon-folder"></i>
              </div>
              <div class="module-text">
                <div class="module-title">分类管理</div>
                <div class="module-desc">管理教材分类</div>
              </div>
            </div>
          </el-card>
        </el-col>
      </el-row>
      
      <!-- 统计信息 -->
      <el-row :gutter="20" class="mt-20">
        <el-col :span="24">
          <el-card class="chart-card">
            <template #header>
              <span class="chart-title">教材管理概览</span>
            </template>
            <div class="stats-container">
              <div class="stat-item">
                <div class="stat-number">{{ textbookStats.totalTextbooks }}</div>
                <div class="stat-label">教材总数</div>
              </div>
              <div class="stat-item">
                <div class="stat-number">{{ inventoryStats.totalInventory }}</div>
                <div class="stat-label">库存总量</div>
              </div>
              <div class="stat-item">
                <div class="stat-number">{{ requestStats.totalRequests }}</div>
                <div class="stat-label">征订申请</div>
              </div>
              <div class="stat-item">
                <div class="stat-number">{{ returnsStats.totalReturns }}</div>
                <div class="stat-label">退库总数</div>
              </div>
            </div>
          </el-card>
        </el-col>
      </el-row>
    </div>
  </div>
</template>

<script setup name="TextbookList">
import useUserStore from '@/store/modules/user'
import { listBooks } from '@/api/textbook/books'
import { listInventory } from '@/api/system/inventory'
import { listRequests } from '@/api/system/requests'
import { listReturns } from '@/api/system/returns'

const userStore = useUserStore()

// 统计数据
const textbookStats = ref({ totalTextbooks: 0 })
const inventoryStats = ref({ totalInventory: 0 })
const requestStats = ref({ totalRequests: 0 })
const returnsStats = ref({ totalReturns: 0 })

// 权限检查
const hasTeachingPlanPermission = computed(() => {
  return userStore.roles.includes('admin') || 
         userStore.permissions.includes('textbook:teachingplan:list')
})

const hasTextbookPermission = computed(() => {
  return userStore.roles.includes('admin') || 
         userStore.permissions.includes('textbook:books:list')
})

const hasRequestPermission = computed(() => {
  return userStore.roles.includes('admin') || 
         userStore.permissions.includes('system:requests:list')
})

const hasInventoryPermission = computed(() => {
  return userStore.roles.includes('admin') || 
         userStore.permissions.includes('system:inventory:list')
})

const hasLogPermission = computed(() => {
  return userStore.roles.includes('admin') || 
         userStore.permissions.includes('system:logs:list')
})

const hasReturnsPermission = computed(() => {
  return userStore.roles.includes('admin') || 
         userStore.permissions.includes('system:returns:list')
})

const hasCoursePermission = computed(() => {
  return userStore.roles.includes('admin') || 
         userStore.permissions.includes('textbook:course:list')
})

const hasCategoryPermission = computed(() => {
  return userStore.roles.includes('admin') || 
         userStore.permissions.includes('system:categories:list')
})

// 加载统计数据
onMounted(() => {
  loadStats()
})

// 加载统计信息
async function loadStats() {
  try {
    if (hasTextbookPermission.value) {
      const textbooksRes = await listBooks({ pageSize: 1000 })
      textbookStats.value.totalTextbooks = textbooksRes.total || 0
    }
    
    if (hasInventoryPermission.value) {
      const inventoryRes = await listInventory({ pageSize: 1000 })
      // 计算总库存数量
      inventoryStats.value.totalInventory = inventoryRes.rows.reduce((sum, item) => sum + (item.totalQuantity || 0), 0)
    }
    
    if (hasRequestPermission.value) {
      const requestsRes = await listRequests({ pageSize: 1000 })
      requestStats.value.totalRequests = requestsRes.total || 0
    }
    
    if (hasReturnsPermission.value) {
      const returnsRes = await listReturns({ pageSize: 1000 })
      returnsStats.value.totalReturns = returnsRes.total || 0
    }
  } catch (error) {
    console.error('加载统计数据失败:', error)
  }
}
</script>

<style scoped>
.module-card {
  cursor: pointer;
  transition: all 0.3s;
  height: 120px;
}

.module-card:hover {
  transform: translateY(-5px);
  box-shadow: 0 8px 16px rgba(0,0,0,0.15);
}

.module-item {
  display: flex;
  align-items: center;
}

.module-icon {
  width: 60px;
  height: 60px;
  border-radius: 10px;
  display: flex;
  align-items: center;
  justify-content: center;
  color: white;
  font-size: 24px;
  margin-right: 15px;
}

.module-text {
  flex: 1;
}

.module-title {
  font-size: 16px;
  font-weight: bold;
  margin-bottom: 5px;
}

.module-desc {
  font-size: 12px;
  color: #999;
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

.bg-purple {
  background-color: #9013FE;
}

.bg-red {
  background-color: #F56C6C;
}

.bg-cyan {
  background-color: #20B2AA;
}

.bg-teal {
  background-color: #008080;
}

.bg-indigo {
  background-color: #4B0082;
}

.stats-container {
  display: flex;
  justify-content: space-around;
}

.stat-item {
  text-align: center;
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

.chart-card {
  min-height: 200px;
}

.chart-title {
  font-weight: bold;
  font-size: 16px;
}
</style>