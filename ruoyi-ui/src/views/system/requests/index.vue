<template>
  <div class="app-container">
    <el-form :model="queryParams" ref="queryRef" :inline="true" v-show="showSearch" label-width="68px">
      <el-form-item label="申请人" prop="teacherId">
        <el-input
          v-model="queryParams.teacherId"
          placeholder="请输入申请人"
          clearable
          @keyup.enter="handleQuery"
        />
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
        <el-input
          v-model="queryParams.courseName"
          placeholder="请输入课程名称"
          clearable
          @keyup.enter="handleQuery"
        />
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
        <el-select v-model="queryParams.status" placeholder="请选择状态" clearable>
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
        <el-input
          v-model="queryParams.reviewedBy"
          placeholder="请输入审核人"
          clearable
          @keyup.enter="handleQuery"
        />
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
      <el-table-column label="申请人" align="center" prop="teacherId" />
      <el-table-column label="申请教材" align="center" prop="textbookId" />
      <el-table-column label="课程名称" align="center" prop="courseName" />
      <el-table-column label="授课班级" align="center" prop="classId" />
      <el-table-column label="申请数量" align="center" prop="quantity" />
      <el-table-column label="状态" align="center" prop="status" v-if="hasStatusPermission">
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
      <el-table-column label="审核人" align="center" prop="reviewedBy" v-if="hasReviewPermission" />
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
      <el-form ref="requestsRef" :model="form" :rules="rules" label-width="80px">
        <el-form-item label="申请人" prop="teacherId">
          <el-input v-model="form.teacherId" placeholder="请输入申请人" :disabled="isReviewMode" />
        </el-form-item>
        <el-form-item label="申请教材" prop="textbookId">
          <el-select 
            v-model="form.textbookId" 
            placeholder="请选择申请教材" 
            clearable 
            filterable
            :disabled="isReviewMode"
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
          <el-input v-model="form.courseName" placeholder="请输入课程名称" :disabled="isReviewMode" />
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
          <el-input v-model="form.quantity" placeholder="请输入申请数量" :disabled="isReviewMode" />
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
          <el-input v-model="form.reviewedBy" placeholder="请输入审核人" disabled />
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

<script setup name="Requests">
import { listRequests, getRequests, delRequests, addRequests, updateRequests } from "@/api/system/requests"
import useUserStore from '@/store/modules/user'
import { listBooks } from "@/api/textbook/books"
import { listDept } from "@/api/system/dept"
import { deptTreeSelect } from "@/api/system/user"
import { updateInventory, getInventory, addInventory } from "@/api/system/inventory"
import { addLogs } from "@/api/system/logs"
import request from '@/utils/request'

const { proxy } = getCurrentInstance()
const { textbook_status } = proxy.useDict('textbook_status')
const userStore = useUserStore()

// 检查用户是否有权限查看状态
const hasStatusPermission = computed(() => {
  // 默认情况下，只有特定角色才能查看状态
  return userStore.roles.includes('admin') ||
         userStore.roles.includes('教材管理员') ||
         userStore.permissions.includes('system:requests:status')
})

// 检查用户是否有审核权限
const hasReviewPermission = computed(() => {
  // 只有特定角色才能进行审核操作
  return userStore.roles.includes('admin') ||
         userStore.roles.includes('教材管理员') ||
         userStore.permissions.includes('system:requests:review')
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

const data = reactive({
  form: {},
  queryParams: {
    pageNum: 1,
    pageSize: 10,
    teacherId: null,
    textbookId: null,
    courseName: null,
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
    courseName: [
      { required: true, message: "课程名称不能为空", trigger: "blur" }
    ],
    quantity: [
      { required: true, message: "申请数量不能为空", trigger: "blur" },
      { pattern: /^[1-9]\d*$/, message: "申请数量必须为大于0的整数", trigger: "blur" }
    ],
    collegeId: [
      { required: true, message: "所属学院不能为空", trigger: "blur" }
    ],
  }
})

const { queryParams, form, rules } = toRefs(data)

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

// 取消按钮
function cancel() {
  open.value = false
  reset()
}

// 根据ID获取学院名称
function getCollegeNameById(collegeId) {
  if (!collegeId) return '';
  
  const college = collegeOptions.value.find(item => item.deptId == collegeId);
  return college ? college.deptName : collegeId;
}

// 表单重置
function reset() {
  const now = new Date();
  const currentDate = now.toISOString().slice(0, 10);
  
  form.value = {
    requestId: null,
    teacherId: userStore.id,  // 自动填入当前用户ID
    textbookId: null,
    courseName: null,
    classId: null,
    quantity: null,
    status: "0",
    collegeId: null,
    submittedAt: currentDate,     // 自动填入当前日期
    reviewedBy: null,
    reviewedAt: null,
    remarks: null
  }
  isReviewMode.value = false
  proxy.resetForm("requestsRef")
}

// 审核通过后更新库存
function updateInventoryOnApproval(requestData) {
  // 查找对应的库存记录
  getInventoryByTextbookId(requestData.textbookId).then(inventoryResponse => {
    const inventoryData = inventoryResponse.data || {};
    
    // 更新库存数量
    const updatedInventory = {
      inventoryId: inventoryData.inventoryId,
      textbookId: requestData.textbookId,
      totalQuantity: (inventoryData.totalQuantity || 0) + parseInt(requestData.quantity),
      availableQuantity: (inventoryData.availableQuantity || 0) + parseInt(requestData.quantity)
    };
    
    // 如果是新库存记录
    if (!inventoryData.inventoryId) {
      updatedInventory.textbookId = requestData.textbookId;
      addOrUpdateInventory(updatedInventory);
    } else {
      // 更新现有库存
      updateInventory(updatedInventory).then(() => {
        console.log('库存更新成功');
      }).catch(error => {
        console.error('库存更新失败:', error);
      });
    }
    
    // 添加日志记录
    addLogRecord(requestData, parseInt(requestData.quantity));
  }).catch(() => {
    // 如果没有找到库存记录，创建一个新的
    const newInventory = {
      textbookId: requestData.textbookId,
      totalQuantity: parseInt(requestData.quantity),
      availableQuantity: parseInt(requestData.quantity)
    };
    addOrUpdateInventory(newInventory);
    
    // 添加日志记录
    addLogRecord(requestData, parseInt(requestData.quantity));
  });
}

// 根据教材ID获取库存信息
function getInventoryByTextbookId(textbookId) {
  return request({
    url: '/system/inventory/getByTextbookId/' + textbookId,
    method: 'get'
  })
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
    // 设置审核模式
    isReviewMode.value = true
    // 自动填充审核人和审核时间
    form.value.reviewedBy = userStore.id
    form.value.reviewedAt = new Date().toISOString().slice(0, 10)
    open.value = true
    title.value = "审核征订申请"
  })
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
        addRequests(form.value).then(response => {
          proxy.$modal.msgSuccess("新增成功")
          open.value = false
          getList()
        })
      }
    }
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
  getList()
  getTextbookList()
  getClassList()
  getCollegeList()
  console.log('Component initialized.');
})

</script>

