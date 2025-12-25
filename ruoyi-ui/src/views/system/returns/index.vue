<template>
  <div class="app-container">
    <el-form :model="queryParams" ref="queryRef" :inline="true" v-show="showSearch" label-width="68px">
      <el-form-item label="教材名称" prop="textbookId">
        <el-select v-model="queryParams.textbookId" placeholder="请选择教材名称" clearable filterable>
          <el-option
            v-for="item in textbookOptions"
            :key="item.textbookId"
            :label="item.title"
            :value="item.textbookId"
          />
        </el-select>
      </el-form-item>
      <el-form-item label="退库类型" prop="returnType">
        <el-select v-model="queryParams.returnType" placeholder="请选择退库类型" clearable style="width: 120px;">
          <el-option label="学生退学" value="student_withdrawal"></el-option>
          <el-option label="课程调整" value="course_adjustment"></el-option>
          <el-option label="学生转专业" value="major_transfer"></el-option>
          <el-option label="其他" value="other"></el-option>
        </el-select>
      </el-form-item>
      <el-form-item label="退库人" prop="returnerId">
        <el-select v-model="queryParams.returnerId" placeholder="请选择退库人" clearable filterable>
          <el-option
            v-for="item in userOptions"
            :key="item.userId"
            :label="item.userName"
            :value="item.userId"
          />
        </el-select>
      </el-form-item>
      <el-form-item label="退库时间" prop="returnDate">
        <el-date-picker clearable
          v-model="queryParams.returnDate"
          type="date"
          value-format="YYYY-MM-DD"
          placeholder="请选择退库时间">
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
          v-hasPermi="['system:returns:add']"
        >新增</el-button>
      </el-col>
      <el-col :span="1.5">
        <el-button
          type="success"
          plain
          icon="Edit"
          :disabled="single"
          @click="handleUpdate"
          v-hasPermi="['system:returns:edit']"
        >修改</el-button>
      </el-col>
      <el-col :span="1.5">
        <el-button
          type="danger"
          plain
          icon="Delete"
          :disabled="multiple"
          @click="handleDelete"
          v-hasPermi="['system:returns:remove']"
        >删除</el-button>
      </el-col>
      <el-col :span="1.5">
        <el-button
          type="warning"
          plain
          icon="Download"
          @click="handleExport"
          v-hasPermi="['system:returns:export']"
        >导出</el-button>
      </el-col>
      <right-toolbar v-model:showSearch="showSearch" @queryTable="getList"></right-toolbar>
    </el-row>

    <el-table v-loading="loading" :data="returnsList" @selection-change="handleSelectionChange">
      <el-table-column type="selection" width="55" align="center" />
      <el-table-column label="退库ID" align="center" prop="returnId" />
      <el-table-column label="教材名称" align="center" prop="textbookId">
        <template #default="scope">
          {{ getTextbookNameById(scope.row.textbookId) }}
        </template>
      </el-table-column>
      <el-table-column label="退库类型" align="center" prop="returnType">
        <template #default="scope">
          {{ getReturnTypeName(scope.row.returnType) }}
        </template>
      </el-table-column>
      <el-table-column label="数量" align="center" prop="quantity" />
      <el-table-column label="退库人" align="center" prop="returnerId">
        <template #default="scope">
          {{ getUserNameById(scope.row.returnerId) }}
        </template>
      </el-table-column>
      <el-table-column label="退库时间" align="center" prop="returnDate" width="180">
        <template #default="scope">
          <span>{{ parseTime(scope.row.returnDate, '{y}-{m}-{d}') }}</span>
        </template>
      </el-table-column>
      <el-table-column label="备注" align="center" prop="notes" />
      <el-table-column label="操作" align="center" class-name="small-padding fixed-width">
        <template #default="scope">
          <el-button link type="primary" icon="Edit" @click="handleUpdate(scope.row)" v-hasPermi="['system:returns:edit']">修改</el-button>
          <el-button link type="primary" icon="Delete" @click="handleDelete(scope.row)" v-hasPermi="['system:returns:remove']">删除</el-button>
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

    <!-- 添加或修改教材退库对话框 -->
    <el-dialog :title="title" v-model="open" width="500px" append-to-body>
      <el-form ref="returnsRef" :model="form" :rules="rules" label-width="100px">
        <el-form-item label="教材名称" prop="textbookId">
          <el-select v-model="form.textbookId" placeholder="请选择教材" clearable filterable>
            <el-option
              v-for="item in textbookOptions"
              :key="item.textbookId"
              :label="item.title"
              :value="item.textbookId"
            />
          </el-select>
        </el-form-item>
        <el-form-item label="退库类型" prop="returnType">
          <el-select v-model="form.returnType" placeholder="请选择退库类型">
            <el-option label="学生退学" value="student_withdrawal"></el-option>
            <el-option label="课程调整" value="course_adjustment"></el-option>
            <el-option label="学生转专业" value="major_transfer"></el-option>
            <el-option label="其他" value="other"></el-option>
          </el-select>
        </el-form-item>
        <el-form-item label="数量" prop="quantity">
          <el-input v-model="form.quantity" placeholder="请输入数量" />
        </el-form-item>
        <el-form-item label="退库人" prop="returnerId">
          <el-select v-model="form.returnerId" placeholder="请选择退库人" clearable filterable>
            <el-option
              v-for="item in userOptions"
              :key="item.userId"
              :label="item.userName"
              :value="item.userId"
            />
          </el-select>
        </el-form-item>
        <el-form-item label="退库时间" prop="returnDate">
          <el-date-picker clearable
            v-model="form.returnDate"
            type="date"
            value-format="YYYY-MM-DD"
            placeholder="请选择退库时间">
          </el-date-picker>
        </el-form-item>
        <el-form-item label="备注" prop="notes">
          <el-input v-model="form.notes" type="textarea" placeholder="请输入内容" />
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

<script setup name="ReturnsList">
import { listReturns, getReturns, delReturns, addReturns, updateReturns } from "@/api/system/returns"
import { listBooks } from "@/api/textbook/books"
import { listUser } from "@/api/system/user"
import { updateInventory, getInventory, listInventory, addInventory } from "@/api/system/inventory"  // 添加addInventory导入
import { addLogs } from "@/api/system/logs"
import useUserStore from '@/store/modules/user'

const { proxy } = getCurrentInstance()
const userStore = useUserStore()

const returnsList = ref([])
const open = ref(false)
const loading = ref(true)
const showSearch = ref(true)
const ids = ref([])
const single = ref(true)
const multiple = ref(true)
const total = ref(0)
const title = ref("")
const textbookOptions = ref([])
const userOptions = ref([])

const data = reactive({
  form: {},
  queryParams: {
    pageNum: 1,
    pageSize: 10,
    textbookId: null,
    returnType: null,
    returnerId: null,
    returnDate: null
  },
  rules: {
    textbookId: [
      { required: true, message: "教材名称不能为空", trigger: "change" }
    ],
    returnType: [
      { required: true, message: "退库类型不能为空", trigger: "change" }
    ],
    quantity: [
      { required: true, message: "数量不能为空", trigger: "blur" },
      { pattern: /^[1-9]\d*$/, message: "数量必须为正整数", trigger: "blur" }
    ],
    returnerId: [
      { required: true, message: "退库人不能为空", trigger: "change" }
    ],
    returnDate: [
      { required: true, message: "退库时间不能为空", trigger: "change" }
    ]
  }
})

const { queryParams, form, rules } = toRefs(data)

/** 查询教材退库列表 */
function getList() {
  loading.value = true
  listReturns(queryParams.value).then(response => {
    returnsList.value = response.rows
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

/** 查询用户列表 */
function getUserList() {
  listUser({ pageSize: 1000 }).then(response => {
    userOptions.value = response.rows
  })
}

/** 根据教材ID获取教材名称 */
function getTextbookNameById(textbookId) {
  if (!textbookId) return '';
  
  const textbook = textbookOptions.value.find(item => item.textbookId == textbookId);
  return textbook ? textbook.title : textbookId;
}

/** 根据用户ID获取用户名称 */
function getUserNameById(userId) {
  if (!userId) return '';
  
  const user = userOptions.value.find(item => item.userId == userId);
  return user ? user.userName : userId;
}

/** 获取退库类型名称 */
function getReturnTypeName(returnType) {
  const typeMap = {
    'student_withdrawal': '学生退学',
    'course_adjustment': '课程调整',
    'major_transfer': '学生转专业',
    'other': '其他'
  };
  return typeMap[returnType] || returnType;
}

// 取消按钮
function cancel() {
  open.value = false
  reset()
}

// 表单重置
function reset() {
  form.value = {
    returnId: null,
    textbookId: null,
    returnType: null,
    quantity: null,
    returnerId: null,
    returnDate: null,
    notes: null
  }
  proxy.resetForm("returnsRef")
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
  ids.value = selection.map(item => item.returnId)
  single.value = selection.length != 1
  multiple.value = !selection.length
}

/** 新增按钮操作 */
function handleAdd() {
  reset()
  open.value = true
  title.value = "添加教材退库"
}

/** 修改按钮操作 */
function handleUpdate(row) {
  reset()
  const _returnId = row.returnId || ids.value
  getReturns(_returnId).then(response => {
    form.value = response.data
    open.value = true
    title.value = "修改教材退库"
  })
}

/** 提交按钮 */
function submitForm() {
  proxy.$refs["returnsRef"].validate(valid => {
    if (valid) {
      if (form.value.returnId != null) {
        updateReturns(form.value).then(response => {
          proxy.$modal.msgSuccess("修改成功")
          open.value = false
          getList()
        })
      } else {
        addReturns(form.value).then(response => {
          proxy.$modal.msgSuccess("新增成功")
          // 更新库存
          updateInventoryOnReturn(form.value)
          open.value = false
          getList()
        })
      }
    }
  })
}

/** 退库后更新库存 */
function updateInventoryOnReturn(returnData) {
  // 查找对应的库存记录
  listInventory({ textbookId: returnData.textbookId, pageSize: 1 }).then(response => {
    if (response.rows && response.rows.length > 0) {
      const inventory = response.rows[0];
      // 更新库存数量
      const updatedInventory = {
        ...inventory,
        totalQuantity: (inventory.totalQuantity || 0) + parseInt(returnData.quantity),
        availableQuantity: (inventory.availableQuantity || 0) + parseInt(returnData.quantity)
      };
      
      // 验证库存数量限制
      if (updatedInventory.totalQuantity < updatedInventory.availableQuantity) {
        proxy.$modal.msgError("退库后总数量不能小于可用数量");
        return;
      }
      
      updateInventory(updatedInventory).then(() => {
        console.log('库存更新成功');
        // 添加日志记录
        addLogRecord(returnData, parseInt(returnData.quantity));
      }).catch(error => {
        console.error('库存更新失败:', error);
        proxy.$modal.msgError("库存更新失败");
      });
    } else {
      // 如果没有找到库存记录，创建新的库存记录
      const newInventory = {
        textbookId: returnData.textbookId,
        categoryId: getTextbookById(returnData.textbookId)?.categoryId || null,
        collegeId: null, // 退库时暂时不指定学院
        totalQuantity: parseInt(returnData.quantity),
        availableQuantity: parseInt(returnData.quantity)
      };
      
      addInventory(newInventory).then(() => {
        console.log('新库存记录创建成功');
        // 添加日志记录
        addLogRecord(returnData, parseInt(returnData.quantity));
      }).catch(error => {
        console.error('新库存记录创建失败:', error);
        proxy.$modal.msgError("新库存记录创建失败");
      });
    }
  }).catch(error => {
    console.error('查找库存记录失败:', error);
    proxy.$modal.msgError("查找库存记录失败");
  });
}

/** 添加日志记录 */
function addLogRecord(returnData, quantity) {
  const logData = {
    textbookId: returnData.textbookId,
    operation: '0', // 退库操作视为入库
    quantity: quantity,
    operatorId: userStore.id,
    relatedRequestId: null, // 关联的退库ID
    notes: `教材退库 - 类型: ${getReturnTypeName(returnData.returnType)}, 退库人: ${getUserNameById(returnData.returnerId)}`,
    createdAt: returnData.returnDate
  };
  
  addLogs(logData).then(() => {
    console.log('日志记录添加成功');
  }).catch(error => {
    console.error('日志记录添加失败:', error);
  });
}

/** 根据教材ID获取教材信息 */
function getTextbookById(textbookId) {
  if (!textbookId || !textbookOptions.value) return null;
  return textbookOptions.value.find(item => item.textbookId == textbookId);
}

/** 删除按钮操作 */
function handleDelete(row) {
  const _returnIds = row.returnId || ids.value
  proxy.$modal.confirm('是否确认删除教材退库编号为"' + _returnIds + '"的数据项？').then(function() {
    return delReturns(_returnIds)
  }).then(() => {
    getList()
    proxy.$modal.msgSuccess("删除成功")
  }).catch(() => {})
}

/** 导出按钮操作 */
function handleExport() {
  proxy.download('system/returns/export', {
    ...queryParams.value
  }, `returns_${new Date().getTime()}.xlsx`)
}

onMounted(() => {
  getList()
  getTextbookList()
  getUserList()
})
</script>