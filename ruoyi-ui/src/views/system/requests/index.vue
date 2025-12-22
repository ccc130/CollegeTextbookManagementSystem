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
        <el-input
          v-model="queryParams.textbookId"
          placeholder="请输入申请教材"
          clearable
          @keyup.enter="handleQuery"
        />
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
        <el-input
          v-model="queryParams.classId"
          placeholder="请输入授课班级"
          clearable
          @keyup.enter="handleQuery"
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
        <el-input
          v-model="queryParams.collegeId"
          placeholder="请输入所属学院"
          clearable
          @keyup.enter="handleQuery"
        />
      </el-form-item>
      <el-form-item label="提交时间" prop="submittedAt">
        <el-date-picker clearable
          v-model="queryParams.submittedAt"
          type="date"
          value-format="YYYY-MM-DD"
          placeholder="请选择提交时间">
        </el-date-picker>
      </el-form-item>
      <el-form-item label="审核人" prop="reviewedBy">
        <el-input
          v-model="queryParams.reviewedBy"
          placeholder="请输入审核人"
          clearable
          @keyup.enter="handleQuery"
        />
      </el-form-item>
      <el-form-item label="审核时间" prop="reviewedAt">
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
      <el-table-column label="状态" align="center" prop="status">
        <template #default="scope">
          <dict-tag :options="textbook_status" :value="scope.row.status"/>
        </template>
      </el-table-column>
      <el-table-column label="所属学院" align="center" prop="collegeId" />
      <el-table-column label="提交时间" align="center" prop="submittedAt" width="180">
        <template #default="scope">
          <span>{{ parseTime(scope.row.submittedAt, '{y}-{m}-{d}') }}</span>
        </template>
      </el-table-column>
      <el-table-column label="审核人" align="center" prop="reviewedBy" />
      <el-table-column label="审核时间" align="center" prop="reviewedAt" width="180">
        <template #default="scope">
          <span>{{ parseTime(scope.row.reviewedAt, '{y}-{m}-{d}') }}</span>
        </template>
      </el-table-column>
      <el-table-column label="审核意见" align="center" prop="remarks" />
      <el-table-column label="操作" align="center" class-name="small-padding fixed-width">
        <template #default="scope">
          <el-button link type="primary" icon="Edit" @click="handleUpdate(scope.row)" v-hasPermi="['system:requests:edit']">修改</el-button>
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
          <el-input v-model="form.teacherId" placeholder="请输入申请人" />
        </el-form-item>
        <el-form-item label="申请教材" prop="textbookId">
          <el-input v-model="form.textbookId" placeholder="请输入申请教材" />
        </el-form-item>
        <el-form-item label="课程名称" prop="courseName">
          <el-input v-model="form.courseName" placeholder="请输入课程名称" />
        </el-form-item>
        <el-form-item label="授课班级" prop="classId">
          <el-input v-model="form.classId" placeholder="请输入授课班级" />
        </el-form-item>
        <el-form-item label="申请数量" prop="quantity">
          <el-input v-model="form.quantity" placeholder="请输入申请数量" />
        </el-form-item>
        <el-form-item label="状态" prop="status">
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
          <el-input v-model="form.collegeId" placeholder="请输入所属学院" />
        </el-form-item>
        <el-form-item label="提交时间" prop="submittedAt">
          <el-date-picker clearable
            v-model="form.submittedAt"
            type="date"
            value-format="YYYY-MM-DD"
            placeholder="请选择提交时间">
          </el-date-picker>
        </el-form-item>
        <el-form-item label="审核人" prop="reviewedBy">
          <el-input v-model="form.reviewedBy" placeholder="请输入审核人" />
        </el-form-item>
        <el-form-item label="审核时间" prop="reviewedAt">
          <el-date-picker clearable
            v-model="form.reviewedAt"
            type="date"
            value-format="YYYY-MM-DD"
            placeholder="请选择审核时间">
          </el-date-picker>
        </el-form-item>
        <el-form-item label="审核意见" prop="remarks">
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

const { proxy } = getCurrentInstance()
const { textbook_status } = proxy.useDict('textbook_status')

const requestsList = ref([])
const open = ref(false)
const loading = ref(true)
const showSearch = ref(true)
const ids = ref([])
const single = ref(true)
const multiple = ref(true)
const total = ref(0)
const title = ref("")

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
      { required: true, message: "申请数量不能为空", trigger: "blur" }
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

// 取消按钮
function cancel() {
  open.value = false
  reset()
}

// 表单重置
function reset() {
  form.value = {
    requestId: null,
    teacherId: null,
    textbookId: null,
    courseName: null,
    classId: null,
    quantity: null,
    status: null,
    collegeId: null,
    submittedAt: null,
    reviewedBy: null,
    reviewedAt: null,
    remarks: null
  }
  proxy.resetForm("requestsRef")
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

/** 提交按钮 */
function submitForm() {
  proxy.$refs["requestsRef"].validate(valid => {
    if (valid) {
      if (form.value.requestId != null) {
        updateRequests(form.value).then(response => {
          proxy.$modal.msgSuccess("修改成功")
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

getList()
</script>
