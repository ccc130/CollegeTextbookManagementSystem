<template>
  <div class="app-container">
    <el-form :model="queryParams" ref="queryRef" :inline="true" v-show="showSearch" label-width="68px">
      <el-form-item label="申请人" prop="teacherId">
        <el-select 
          v-model="queryParams.teacherId" 
          placeholder="请选择申请人" 
          clearable 
          filterable
        >
          <el-option
            v-for="item in userOptions"
            :key="item.userId"
            :label="item.userName"
            :value="item.userId"
          />
        </el-select>
      </el-form-item>
      <el-form-item label="申请教材" prop="textbookId">
        <el-select 
          v-model="queryParams.textbookId" 
          placeholder="请选择申请教材" 
          clearable 
          filterable
        >
          <el-option
            v-for="item in textbookOptions"
            :key="item.textbookId"
            :label="item.title"
            :value="item.textbookId"
          />
        </el-select>
      </el-form-item>
      <el-form-item label="课程名称" prop="courseName">
        <el-select 
          v-model="queryParams.courseName" 
          placeholder="请选择课程" 
          clearable 
          filterable
        >
          <el-option
            v-for="item in courseOptions"
            :key="item.courseId"
            :label="item.courseName"
            :value="item.courseId"
          />
        </el-select>
      </el-form-item>
      <el-form-item label="授课班级" prop="classId">
        <el-tree-select
          v-model="queryParams.classId"
          :data="classOptions"
          :props="{ value: 'deptId', label: 'deptName', children: 'children' }"
          value-key="deptId"
          placeholder="请选择授课班级"
          clearable
          filterable
        />
      </el-form-item>
      <el-form-item label="状态" prop="status">
        <el-select v-model="queryParams.status" placeholder="请选择状态" clearable style="width: 120px;">
          <el-option
            v-for="dict in textbook_status"
            :key="dict.value"
            :label="dict.label"
            :value="dict.value"
          />
        </el-select>
      </el-form-item>
      <el-form-item label="所属学院" prop="collegeId">
        <el-select 
          v-model="queryParams.collegeId" 
          placeholder="请选择所属学院" 
          clearable 
          filterable
        >
          <el-option
            v-for="item in collegeOptions"
            :key="item.deptId"
            :label="item.deptName"
            :value="item.deptId"
          />
        </el-select>
      </el-form-item>
      <el-form-item label="提交时间" prop="submittedAt">
        <el-date-picker clearable
          v-model="queryParams.submittedAt"
          type="date"
          value-format="YYYY-MM-DD"
          placeholder="请选择提交时间">
        </el-date-picker>
      </el-form-item>
      <el-form-item label="审核人" prop="reviewedBy" v-if="hasReviewPermission">
        <el-select 
          v-model="queryParams.reviewedBy" 
          placeholder="请选择审核人" 
          clearable 
          filterable
        >
          <el-option
            v-for="item in userOptions"
            :key="item.userId"
            :label="item.userName"
            :value="item.userId"
          />
        </el-select>
      </el-form-item>
      <el-form-item label="审核时间" prop="reviewedAt" v-if="hasReviewPermission">
        <el-date-picker clearable
          v-model="queryParams.reviewedAt"
          type="date"
          value-format="YYYY-MM-DD"
          placeholder="请选择审核时间">
        </el-date-picker>
      </el-form-item>
      <el-form-item>
        <el-button type="primary" icon="Search" @click="handleQuery">搜索</el-button>
        <el-button icon="Refresh" @click="resetQuery">重置</el-button>
      </el-form-item>
    </el-form>

    <el-row :gutter="10" class="mb8">
      <el-col :span="1.5">
        <el-button
          type="primary"
          plain
          icon="Plus"
          @click="handleAdd"
          v-hasPermi="['system:requests:add']"
        >新增</el-button>
      </el-col>
      <el-col :span="1.5">
        <el-button
          type="success"
          plain
          icon="Edit"
          :disabled="single"
          @click="handleUpdate"
          v-hasPermi="['system:requests:edit']"
        >修改</el-button>
      </el-col>
      <el-col :span="1.5">
        <el-button
          type="warning"
          plain
          icon="View"
          :disabled="single"
          @click="handleReview"
          v-hasPermi="['system:requests:review']"
          v-if="hasReviewPermission"
        >审核</el-button>
      </el-col>
      <el-col :span="1.5">
        <el-button
          type="danger"
          plain
          icon="Delete"
          :disabled="multiple"
          @click="handleDelete"
          v-hasPermi="['system:requests:remove']"
        >删除</el-button>
      </el-col>
      <el-col :span="1.5">
        <el-button
          type="warning"
          plain
          icon="Download"
          @click="handleExport"
          v-hasPermi="['system:requests:export']"
        >导出</el-button>
      </el-col>
      <right-toolbar v-model:showSearch="showSearch" @queryTable="getList"></right-toolbar>
    </el-row>

    <el-table v-loading="loading" :data="requestsList" @selection-change="handleSelectionChange">
      <el-table-column type="selection" width="55" align="center" />
      <el-table-column label="申请ID" align="center" prop="requestId" />
      <el-table-column label="申请人" align="center" prop="teacherId">
        <template #default="scope">
          {{ getUserNameById(scope.row.teacherId) }}
        </template>
      </el-table-column>
      <el-table-column label="申请教材" align="center" prop="textbookId">
        <template #default="scope">
          {{ getTextbookNameById(scope.row.textbookId) }}
        </template>
      </el-table-column>
      <el-table-column label="课程名称" align="center" prop="courseName">
        <template #default="scope">
          {{ getCourseNameById(scope.row.courseName) }}
        </template>
      </el-table-column>
      <el-table-column label="授课班级" align="center" prop="classId">
        <template #default="scope">
          {{ getClassNameById(scope.row.classId) }}
        </template>
      </el-table-column>
      <el-table-column label="申请数量" align="center" prop="quantity" />
      <el-table-column label="状态" align="center" prop="status">
        <template #default="scope">
          <dict-tag :options="textbook_status" :value="scope.row.status"/>
        </template>
      </el-table-column>
      <el-table-column label="所属学院" align="center" prop="collegeId">
        <template #default="scope">
          {{ getCollegeNameById(scope.row.collegeId) }}
        </template>
      </el-table-column>
      <el-table-column label="提交时间" align="center" prop="submittedAt" width="180">
        <template #default="scope">
          <span>{{ parseTime(scope.row.submittedAt, '{y}-{m}-{d}') }}</span>
        </template>
      </el-table-column>
      <el-table-column label="审核人" align="center" prop="reviewedBy" v-if="hasReviewPermission">
        <template #default="scope">
          {{ getUserNameById(scope.row.reviewedBy) }}
        </template>
      </el-table-column>
      <el-table-column label="审核时间" align="center" prop="reviewedAt" width="180" v-if="hasReviewPermission">
        <template #default="scope">
          <span>{{ parseTime(scope.row.reviewedAt, '{y}-{m}-{d}') }}</span>
        </template>
      </el-table-column>
      <el-table-column label="审核意见" align="center" prop="remarks" v-if="hasReviewPermission" />
      <el-table-column label="操作" align="center" class-name="small-padding fixed-width">
        <template #default="scope">
          <el-button link type="primary" icon="Edit" @click="handleUpdate(scope.row)" v-hasPermi="['system:requests:edit']">修改</el-button>
          <el-button link type="primary" icon="View" @click="handleReview(scope.row)" v-hasPermi="['system:requests:review']" v-if="hasReviewPermission">审核</el-button>
          <el-button link type="primary" icon="Delete" @click="handleDelete(scope.row)" v-hasPermi="['system:requests:remove']">删除</el-button>
        </template>
      </el-table-column>
    </el-table>
    
    <pagination
      v-show="total>0"
      :total="total"
      v-model:page="queryParams.pageNum"
      v-model:limit="queryParams.pageSize"
      @pagination="getList"
    />

    <!-- 添加或修改征订申请对话框 -->
    <el-dialog :title="title" v-model="open" width="500px" append-to-body>
      <el-form ref="requestsRef" :model="form" :rules="rules" label-width="100px">
        <el-form-item label="申请人" prop="teacherId">
          <el-select 
            v-model="form.teacherId" 
            placeholder="请选择申请人" 
            clearable 
            filterable
            :disabled="isReviewMode"
          >
            <el-option
              v-for="item in userOptions"
              :key="item.userId"
              :label="item.userName"
              :value="item.userId"
            />
          </el-select>
        </el-form-item>
        <el-form-item label="申请教材" prop="textbookId">
          <el-select 
            v-model="form.textbookId" 
            placeholder="请选择申请教材" 
            clearable 
            filterable
            :disabled="isReviewMode"
            @change="handleTextbookChange"
          >
            <el-option
              v-for="item in textbookOptions"
              :key="item.textbookId"
              :label="item.title + ' (库存: ' + (inventoryMap[item.textbookId] ? inventoryMap[item.textbookId].availableQuantity : 0) + ')'"
              :value="item.textbookId"
            />
          </el-select>
        </el-form-item>
        <el-form-item label="课程名称" prop="courseName">
          <el-select 
            v-model="form.courseName" 
            placeholder="请选择课程" 
            clearable 
            filterable
            :disabled="isReviewMode"
          >
            <el-option
              v-for="item in courseOptions"
              :key="item.courseId"
              :label="item.courseName"
              :value="item.courseId"
            />
          </el-select>
        </el-form-item>
        <el-form-item label="授课班级" prop="classId">
          <el-tree-select
            v-model="form.classId"
            :data="classOptions"
            :props="{ value: 'deptId', label: 'deptName', children: 'children' }"
            value-key="deptId"
            placeholder="请选择授课班级"
            clearable
            filterable
            :disabled="isReviewMode"
          />
        </el-form-item>
        <el-form-item label="申请数量" prop="quantity">
          <el-input 
            v-model="form.quantity" 
            placeholder="请输入申请数量" 
            :disabled="isReviewMode"
            @input="handleQuantityChange"
          />
          <div v-if="selectedTextbookInventory !== null" class="inventory-info">
            当前库存: {{ selectedTextbookInventory }} 
            <span v-if="form.quantity && parseInt(form.quantity) > selectedTextbookInventory" style="color: red;">
              (库存不足)
            </span>
          </div>
        </el-form-item>
        <el-form-item label="状态" prop="status" v-if="hasStatusPermission">
          <el-select v-model="form.status" placeholder="请选择状态">
            <el-option
              v-for="dict in textbook_status"
              :key="dict.value"
              :label="dict.label"
              :value="parseInt(dict.value)"
            ></el-option>
          </el-select>
        </el-form-item>
        <el-form-item label="所属学院" prop="collegeId">
          <el-select 
            v-model="form.collegeId" 
            placeholder="请选择所属学院" 
            clearable 
            filterable
            :disabled="isReviewMode"
          >
            <el-option
              v-for="item in collegeOptions"
              :key="item.deptId"
              :label="item.deptName"
              :value="item.deptId"
            />
          </el-select>
        </el-form-item>
        <el-form-item label="提交时间" prop="submittedAt">
          <el-date-picker clearable
            v-model="form.submittedAt"
            type="date"
            value-format="YYYY-MM-DD"
            placeholder="请选择提交时间"
            :disabled="true">
          </el-date-picker>
        </el-form-item>
        <el-form-item label="审核人" prop="reviewedBy" v-if="hasReviewPermission">
          <el-select 
            v-model="form.reviewedBy" 
            placeholder="请选择审核人" 
            clearable 
            filterable
            disabled
          >
            <el-option
              v-for="item in userOptions"
              :key="item.userId"
              :label="item.userName"
              :value="item.userId"
            />
          </el-select>
        </el-form-item>
        <el-form-item label="审核时间" prop="reviewedAt" v-if="hasReviewPermission">
          <el-date-picker clearable
            v-model="form.reviewedAt"
            type="date"
            value-format="YYYY-MM-DD"
            placeholder="请选择审核时间"
            :disabled="true">
          </el-date-picker>
        </el-form-item>
        <el-form-item label="审核意见" prop="remarks" v-if="hasReviewPermission">
          <el-input v-model="form.remarks" type="textarea" placeholder="请输入内容" />
        </el-form-item>
      </el-form>
      <template #footer>
        <div class="dialog-footer">
          <el-button type="primary" @click="submitForm">确 定</el-button>
          <el-button @click="cancel">取 消</el-button>
        </div>
      </template>
    </el-dialog>
  </div>
</template>

<script setup name="RequestsList">
import { listRequests, getRequests, delRequests, addRequests, updateRequests } from "@/api/system/requests"

import useUserStore from '@/store/modules/user'
import { listBooks } from "@/api/textbook/books"
import { listDept } from "@/api/system/dept"
import { deptTreeSelect, listUser } from "@/api/system/user"
import { updateInventory, getInventory, addInventory, listInventory } from "@/api/system/inventory"
import { addLogs } from "@/api/system/logs"
import { listCourse } from "@/api/textbook/course"
import { listTeachingplan } from "@/api/textbook/teachingplan"  // 添加教学计划API
import request from '@/utils/request'

const { proxy } = getCurrentInstance()
const { textbook_status } = proxy.useDict('textbook_status')
const userStore = useUserStore()

// 检查用户是否有审核权限
const hasReviewPermission = computed(() => {
  // 只有特定角色才能进行审核操作
  return userStore.roles.includes('admin') ||
         userStore.permissions.includes('system:requests:review')
})

// 检查用户是否有状态修改权限（在审核模式下）
const hasStatusPermission = computed(() => {
  return hasReviewPermission.value || isReviewMode.value;
})

const requestsList = ref([])
const open = ref(false)
const loading = ref(true)
const showSearch = ref(true)
const ids = ref([])
const single = ref(true)
const multiple = ref(true)
const total = ref(0)
const title = ref("")
const isReviewMode = ref(false)
const textbookOptions = ref([])
const classOptions = ref([])
const collegeOptions = ref([])
const userOptions = ref([])
const courseOptions = ref([])
const teachingPlanOptions = ref([])  // 添加教学计划选项
// 添加库存映射和当前选中教材的库存信息
const inventoryMap = ref({})
const selectedTextbookInventory = ref(null)

const data = reactive({
  form: {},
  queryParams: {
    pageNum: 1,
    pageSize: 10,
    teacherId: hasReviewPermission.value ? null : userStore.id, // 无审核权限时，默认只显示当前用户申请的记录
    textbookId: null,
    courseid: null,
    classId: null,
    status: null,
    collegeId: null,
    submittedAt: null,
    reviewedBy: null,
    reviewedAt: null,
  },
  rules: {
    teacherId: [
      { required: true, message: "申请人不能为空", trigger: "blur" }
    ],
    textbookId: [
      { required: true, message: "申请教材不能为空", trigger: "blur" }
    ],
    courseid: [
      { required: true, message: "课程名称不能为空", trigger: "blur" }
    ],
    teachingPlanId: [
      { required: true, message: "教学计划不能为空", trigger: "change" }
    ],
    classId: [
      { required: true, message: "授课班级不能为空", trigger: "change" }
    ],
    quantity: [
      { required: true, message: "申请数量不能为空", trigger: "blur" },
      { pattern: /^[1-9]\d*$/, message: "申请数量必须为大于0的整数", trigger: "blur" },
      { validator: validateQuantityAgainstInventory, trigger: "blur" }
    ],
  }
})

const { queryParams, form, rules } = toRefs(data)

// 验证申请数量是否超过库存
function validateQuantityAgainstInventory(rule, value, callback) {
  if (!value) {
    callback()
    return
  }

  const quantity = parseInt(value)
  if (isNaN(quantity) || quantity <= 0) {
    callback(new Error("申请数量必须为大于0的整数"))
    return
  }

  // 如果没有选中教材或没有库存信息，则跳过验证
  if (!form.value.textbookId || selectedTextbookInventory.value === null) {
    callback()
    return
  }

  callback()
}

/** 查询征订申请列表 */
function getList() {
  loading.value = true
  listRequests(queryParams.value).then(response => {
    requestsList.value = response.rows
    total.value = response.total
    loading.value = false
  })
}

/** 查询教材信息列表 */
function getTextbookList() {
  listBooks({ pageSize: 1000 }).then(response => {
    textbookOptions.value = response.rows
  })
}

/** 查询课程列表 */
function getCourseList() {
  listCourse({ pageSize: 1000 }).then(response => {
    courseOptions.value = response.rows.map(course => {
      // 兼容不同的字段名
      return {
        courseId: course.courseId || course.CourseID || course.id,
        courseName: course.coursename || course.CourseName || course.name
      }
    })
    console.log('Course options loaded:', courseOptions.value);
  }).catch(error => {
    console.error('Failed to load course data:', error);
  })
}

/** 查询教学计划列表 */
function getTeachingPlanList() {
  import("@/api/textbook/teachingplan").then(({ listTeachingplan }) => {
    listTeachingplan({ pageSize: 1000 }).then(response => {
      teachingPlanOptions.value = response.rows
    })
  })
}

/** 查询部门列表 */
function getClassList() {
  listDept().then(response => {
    classOptions.value = proxy.handleTree(response.data, "deptId")
  })
}

/** 获取学院选项列表（仅二级目录）*/
function getCollegeList() {
  deptTreeSelect().then(response => {
    // 过滤出二级目录作为学院选项
    collegeOptions.value = [];
    
    if (response.data && Array.isArray(response.data)) {
      // 遍历所有顶级部门
      response.data.forEach(dept => {
        // 检查是否有子部门
        if (dept.children && Array.isArray(dept.children) && dept.children.length > 0) {
          // 将子部门作为学院添加到选项中
          dept.children.forEach(college => {
            // 兼容不同的字段名
            const collegeOption = {
              deptId: college.id || college.deptId || college.value,
              deptName: college.label || college.deptName || college.name || college.title
            };
            
            // 确保必要字段存在
            if (collegeOption.deptId && collegeOption.deptName) {
              collegeOptions.value.push(collegeOption);
            }
          });
        }
      });
    }
    
    console.log('College options loaded:', collegeOptions.value);
  }).catch(error => {
    console.error('Failed to load department data:', error);
  });
}

/** 获取用户列表 */
function getUserList() {
  listUser({ pageSize: 1000 }).then(response => {
    userOptions.value = response.rows
  })
}

/** 获取库存列表并构建库存映射 */
function getInventoryList() {
  listInventory({ pageSize: 10000 }).then(response => {
    // 构建库存映射，key为textbookId，value为库存对象
    inventoryMap.value = {}
    response.rows.forEach(item => {
      inventoryMap.value[item.textbookId] = item
    })
    console.log('Inventory map loaded:', inventoryMap.value)
  }).catch(error => {
    console.error('Failed to load inventory data:', error)
  })
}

// 处理教材选择变化
function handleTextbookChange(value) {
  // 更新当前选中教材的库存信息
  if (value && inventoryMap.value[value]) {
    selectedTextbookInventory.value = inventoryMap.value[value].availableQuantity
  } else {
    selectedTextbookInventory.value = 0 // 如果没有库存记录，默认为0
  }
}

// 处理数量输入变化
function handleQuantityChange() {
  // 实时验证数量是否超过库存
  if (form.value.quantity && selectedTextbookInventory.value !== null) {
    const quantity = parseInt(form.value.quantity)
    if (quantity > selectedTextbookInventory.value) {
      // 可以在这里添加警告提示
      console.warn(`申请数量 ${quantity} 超过当前可用库存 ${selectedTextbookInventory.value}`)
    }
  }
}

// 取消按钮
function cancel() {
  open.value = false
  reset()
}

// 根据ID获取教学计划名称
function getTeachingPlanNameById(teachingPlanId) {
  if (!teachingPlanId) return '';
  
  const plan = teachingPlanOptions.value.find(item => item.planId == teachingPlanId);
  if (plan) {
    return `${plan.semester} - ${getClassNameById(plan.classId)} - ${getCourseNameById(plan.courseId)}`;
  }
  return teachingPlanId;
}

// 根据ID获取学院名称
function getCollegeNameById(collegeId) {
  if (!collegeId) return '';
  
  const college = collegeOptions.value.find(item => item.deptId == collegeId);
  return college ? college.deptName : collegeId;
}

// 根据ID获取课程名称
function getCourseNameById(courseId) {
  if (!courseId) return '';
  
  const course = courseOptions.value.find(item => item.courseId == courseId);
  return course ? course.courseName : courseId;
}

// 根据ID获取班级名称
function getClassNameById(classId) {
  if (!classId) return '';
  
  // 递归查找部门名称
  function findDeptName(depts, id) {
    for (const dept of depts) {
      if (dept.deptId == id || dept.id == id) {
        return dept.deptName || dept.label;
      }
      if (dept.children) {
        const found = findDeptName(dept.children, id);
        if (found) return found;
      }
    }
    return id;
  }
  
  return findDeptName(classOptions.value, classId);
}

// 根据ID获取教材名称
function getTextbookNameById(textbookId) {
  if (!textbookId) return '';
  
  const textbook = textbookOptions.value.find(item => item.textbookId == textbookId);
  return textbook ? textbook.title : textbookId;
}

// 根据ID获取用户名称
function getUserNameById(userId) {
  if (!userId) return '';
  
  const user = userOptions.value.find(item => item.userId == userId);
  return user ? user.userName : userId;
}

// 表单重置
function reset() {
  const now = new Date();
  const currentDate = now.toISOString().slice(0, 10);
  
  form.value = {
    requestId: null,
    teacherId: userStore.id,  // 自动填入当前用户ID
    textbookId: null,
    courseId: null,
    classId: null,
    teachingPlanId: null,
    quantity: null,
    status: "0",
    collegeId: null,
    submittedAt: currentDate,     // 自动填入当前日期
    reviewedBy: null,
    reviewedAt: null,
    remarks: null
  }
  isReviewMode.value = false
  selectedTextbookInventory.value = null
  proxy.resetForm("requestsRef")
}

/** 提交按钮 */
function submitForm() {
  proxy.$refs["requestsRef"].validate(valid => {
    if (valid) {
        // 如果是审核模式，确保审核信息正确
        if (isReviewMode.value) {
          form.value.reviewedBy = userStore.id;
          if (!form.value.reviewedAt) {
            const now = new Date();
            form.value.reviewedAt = now.toISOString().slice(0, 10);
          }
        }
      
      if (form.value.requestId != null) {
        // 如果是审核模式，确保审核信息正确
        if (isReviewMode.value) {
          form.value.reviewedBy = userStore.id;
          if (!form.value.reviewedAt) {
            const now = new Date();
            form.value.reviewedAt = now.toISOString().slice(0, 10);
          }
        }
        updateRequests(form.value).then(response => {
          proxy.$modal.msgSuccess("修改成功")
          // 如果审核通过(状态为1)，则更新库存并添加日志记录
          if (form.value.status === '1' || form.value.status === 1) {
            updateInventoryOnApproval(form.value)
          }
          open.value = false
          getList()
        })
      } else {
        // 对于新增申请，验证申请数量不超过库存
        if (form.value.textbookId && selectedTextbookInventory.value !== null) {
          const quantity = parseInt(form.value.quantity)
          if (quantity > selectedTextbookInventory.value) {
            proxy.$modal.msgError(`申请数量不能超过当前可用库存 ${selectedTextbookInventory.value}`)
            return
          }
        }
        
        // 添加课程名称到请求数据
        const requestData = {
          ...form.value,
          courseName: getCourseNameById(form.value.courseId)
        };
        
        addRequests(requestData).then(response => {
          proxy.$modal.msgSuccess("新增成功")
          open.value = false
          getList()
        })
      }
    } else {
      proxy.$modal.msgError("请检查输入信息是否正确")
    }
  })
}

/** 审核通过后更新库存 */
function updateInventoryOnApproval(requestData) {
  // 查找对应的库存记录
  getInventoryByTextbookId(requestData.textbookId).then(inventoryResponse => {
    const inventoryData = inventoryResponse.data || {};
    
    // 更新库存数量
    const newTotalQuantity = (inventoryData.totalQuantity || 0) + parseInt(requestData.quantity);
    const newAvailableQuantity = (inventoryData.availableQuantity || 0) + parseInt(requestData.quantity);
    
    // 验证总数量是否大于等于可领用数量
    if (newTotalQuantity < newAvailableQuantity) {
      proxy.$modal.msgError('库存更新失败：总数量不能小于可领用数量');
      return;
    }
    
    const updatedInventory = {
      inventoryId: inventoryData.inventoryId,
      textbookId: requestData.textbookId,
      totalQuantity: newTotalQuantity,
      availableQuantity: newAvailableQuantity
    };
    
    // 只有当库存记录存在时才更新，否则提示错误
    if (inventoryData.inventoryId) {
      // 更新现有库存
      updateInventory(updatedInventory).then(() => {
        console.log('库存更新成功');
        // 添加日志记录
        addLogRecord(requestData, parseInt(requestData.quantity));
      }).catch(error => {
        console.error('库存更新失败:', error);
        proxy.$modal.msgError("库存更新失败");
      });
    } else {
      // 如果没有找到库存记录，提示用户先创建库存记录
      console.error('库存记录不存在，请先为教材创建库存记录');
      proxy.$modal.msgError('库存记录不存在，请先为教材"' + getTextbookNameById(requestData.textbookId) + '"创建库存记录');
    }
  }).catch(() => {
    // 如果没有找到库存记录，提示用户先创建库存记录
    console.error('库存记录不存在，请先为教材创建库存记录');
    proxy.$modal.msgError('库存记录不存在，请先为教材"' + getTextbookNameById(requestData.textbookId) + '"创建库存记录');
  });
}

// 根据教材ID从库存映射中获取库存信息
function getInventoryByTextbookId(textbookId) {
  return new Promise((resolve, reject) => {
    // 从库存映射中查找对应的库存记录
    const inventoryData = inventoryMap.value[textbookId];
    if (inventoryData) {
      resolve({ data: inventoryData });
    } else {
      reject(new Error('Inventory not found'));
    }
  });
}

// 添加或更新库存
function addOrUpdateInventory(inventoryData) {
  if (inventoryData.inventoryId) {
    updateInventory(inventoryData).then(() => {
      console.log('库存更新成功');
    }).catch(error => {
      console.error('库存更新失败:', error);
    });
  } else {
    addInventory(inventoryData).then(() => {
      console.log('库存添加成功');
    }).catch(error => {
      console.error('库存添加失败:', error);
    });
  }
}

// 添加日志记录
function addLogRecord(requestData, quantity) {
  const logData = {
    textbookId: requestData.textbookId,
    operation: '0', // 入库操作
    quantity: quantity,
    operatorId: userStore.id,
    relatedRequestId: requestData.requestId,
    notes: `征订申请审核通过，申请ID: ${requestData.requestId}`,
    createdAt: new Date().toISOString().slice(0, 10)
  };
  
  addLogs(logData).then(() => {
    console.log('日志记录添加成功');
  }).catch(error => {
    console.error('日志记录添加失败:', error);
  });
}

/** 搜索按钮操作 */
function handleQuery() {
  queryParams.value.pageNum = 1
  getList()
}

/** 重置按钮操作 */
function resetQuery() {
  proxy.resetForm("queryRef")
  // 无审核权限时，重置查询后仍应只显示当前用户申请的记录
  if (!hasReviewPermission.value) {
    queryParams.value.teacherId = userStore.id
  }
  handleQuery()
}

// 多选框选中数据
function handleSelectionChange(selection) {
  ids.value = selection.map(item => item.requestId)
  single.value = selection.length != 1
  multiple.value = !selection.length
}

/** 新增按钮操作 */
function handleAdd() {
  reset()
  // 确保新增时申请人和提交时间正确设置
  form.value.teacherId = userStore.id;
  const now = new Date();
  form.value.submittedAt = now.toISOString().slice(0, 10);
  open.value = true
  title.value = "添加征订申请"
}

/** 修改按钮操作 */
function handleUpdate(row) {
  reset()
  const _requestId = row.requestId || ids.value
  getRequests(_requestId).then(response => {
    form.value = response.data
    // 设置当前选中教材的库存信息
    if (form.value.textbookId && inventoryMap.value[form.value.textbookId]) {
      selectedTextbookInventory.value = inventoryMap.value[form.value.textbookId].availableQuantity
    } else {
      selectedTextbookInventory.value = 0
    }
    open.value = true
    title.value = "修改征订申请"
  })
}

/** 审核按钮操作 */
function handleReview(row) {
  reset()
  const _requestId = row.requestId || ids.value
  getRequests(_requestId).then(response => {
    form.value = response.data
    // 设置当前选中教材的库存信息
    if (form.value.textbookId && inventoryMap.value[form.value.textbookId]) {
      selectedTextbookInventory.value = inventoryMap.value[form.value.textbookId].availableQuantity
    } else {
      selectedTextbookInventory.value = 0
    }
    // 设置审核模式
    isReviewMode.value = true
    // 自动填充审核人和审核时间
    form.value.reviewedBy = userStore.id
    form.value.reviewedAt = new Date().toISOString().slice(0, 10)
    open.value = true
    title.value = "审核征订申请"
  })
}

/** 删除按钮操作 */
function handleDelete(row) {
  const _requestIds = row.requestId || ids.value
  proxy.$modal.confirm('是否确认删除征订申请编号为"' + _requestIds + '"的数据项？').then(function() {
    return delRequests(_requestIds)
  }).then(() => {
    getList()
    proxy.$modal.msgSuccess("删除成功")
  }).catch(() => {})
}

/** 导出按钮操作 */
function handleExport() {
  proxy.download('system/requests/export', {
    ...queryParams.value
  }, `requests_${new Date().getTime()}.xlsx`)
}

onMounted(() => {
  console.log('Initializing component...');
  // 无审核权限时，初始化时也应只显示当前用户申请的记录
  if (!hasReviewPermission.value) {
    queryParams.value.teacherId = userStore.id
  }
  getList()
  getTextbookList()
  getCourseList()
  getClassList()
  getCollegeList()
  getUserList()
  getInventoryList() // 获取库存信息
  getTeachingPlanList() // 获取教学计划信息
  console.log('Component initialized.');
})
</script>