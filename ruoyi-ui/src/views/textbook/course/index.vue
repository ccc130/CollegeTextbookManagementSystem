<template>
  <div class="app-container">
    <el-form :model="queryParams" ref="queryRef" :inline="true" v-show="showSearch" label-width="68px">
      <el-form-item label="课程名称" prop="CourseName">
        <el-input
          v-model="queryParams.CourseName"
          placeholder="请输入课程名称"
          clearable
          @keyup.enter="handleQuery"
        />
      </el-form-item>
      <el-form-item label="课程代码" prop="CourseCode">
        <el-input
          v-model="queryParams.CourseCode"
          placeholder="请输入课程代码"
          clearable
          @keyup.enter="handleQuery"
        />
      </el-form-item>
      <el-form-item label="分类" prop="Category">
        <el-input
          v-model="queryParams.Category"
          placeholder="请输入分类"
          clearable
          @keyup.enter="handleQuery"
        />
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
          v-hasPermi="['textbook:course:add']"
        >新增</el-button>
      </el-col>
      <el-col :span="1.5">
        <el-button
          type="success"
          plain
          icon="Edit"
          :disabled="single"
          @click="handleUpdate"
          v-hasPermi="['textbook:course:edit']"
        >修改</el-button>
      </el-col>
      <el-col :span="1.5">
        <el-button
          type="danger"
          plain
          icon="Delete"
          :disabled="multiple"
          @click="handleDelete"
          v-hasPermi="['textbook:course:remove']"
        >删除</el-button>
      </el-col>
      <el-col :span="1.5">
        <el-button
          type="warning"
          plain
          icon="Download"
          @click="handleExport"
          v-hasPermi="['textbook:course:export']"
        >导出</el-button>
      </el-col>
      <right-toolbar v-model:showSearch="showSearch" @queryTable="getList"></right-toolbar>
    </el-row>

    <el-table v-loading="loading" :data="courseList" @selection-change="handleSelectionChange">
      <el-table-column type="selection" width="55" align="center" />
      <el-table-column label="课程id" align="center" prop="CourseID" />
      <el-table-column label="课程名称" align="center" prop="CourseName" />
      <el-table-column label="课程代码" align="center" prop="CourseCode" />
      <el-table-column label="学分" align="center" prop="Credits" />
      <el-table-column label="分类" align="center" prop="Category" />
      <el-table-column label="描述" align="center" prop="Description" />
      <el-table-column label="操作" align="center" class-name="small-padding fixed-width">
        <template #default="scope">
          <el-button link type="primary" icon="Edit" @click="handleUpdate(scope.row)" v-hasPermi="['textbook:course:edit']">修改</el-button>
          <el-button link type="primary" icon="Delete" @click="handleDelete(scope.row)" v-hasPermi="['textbook:course:remove']">删除</el-button>
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

    <!-- 添加或修改课程管理对话框 -->
    <el-dialog :title="title" v-model="open" width="500px" append-to-body>
      <el-form ref="courseRef" :model="form" :rules="rules" label-width="80px">
        <el-form-item label="课程名称" prop="CourseName">
          <el-input v-model="form.CourseName" placeholder="请输入课程名称" />
        </el-form-item>
        <el-form-item label="课程代码" prop="CourseCode">
          <el-input v-model="form.CourseCode" placeholder="请输入课程代码" />
        </el-form-item>
        <el-form-item label="学分" prop="Credits">
          <el-input v-model="form.Credits" placeholder="请输入学分" />
        </el-form-item>
        <el-form-item label="分类" prop="Category">
          <el-input v-model="form.Category" placeholder="请输入分类" />
        </el-form-item>
        <el-form-item label="描述" prop="Description">
          <el-input v-model="form.Description" type="textarea" placeholder="请输入内容" />
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

<script setup name="Course">
import { listCourse, getCourse, delCourse, addCourse, updateCourse } from "@/api/textbook/course"

const { proxy } = getCurrentInstance()

const courseList = ref([])
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
    CourseName: null,
    CourseCode: null,
    Category: null,
  },
  rules: {
    CourseName: [
      { required: true, message: "课程名称不能为空", trigger: "blur" }
    ],
    CourseCode: [
      { required: true, message: "课程代码不能为空", trigger: "blur" }
    ],
  }
})

const { queryParams, form, rules } = toRefs(data)

/** 查询课程管理列表 */
function getList() {
  loading.value = true
  listCourse(queryParams.value).then(response => {
    courseList.value = response.rows
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
    CourseID: null,
    CourseName: null,
    CourseCode: null,
    Credits: null,
    Category: null,
    Description: null
  }
  proxy.resetForm("courseRef")
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
  ids.value = selection.map(item => item.CourseID)
  single.value = selection.length != 1
  multiple.value = !selection.length
}

/** 新增按钮操作 */
function handleAdd() {
  reset()
  open.value = true
  title.value = "添加课程管理"
}

/** 修改按钮操作 */
function handleUpdate(row) {
  reset()
  const _CourseID = row.CourseID || ids.value
  getCourse(_CourseID).then(response => {
    form.value = response.data
    open.value = true
    title.value = "修改课程管理"
  })
}

/** 提交按钮 */
function submitForm() {
  proxy.$refs["courseRef"].validate(valid => {
    if (valid) {
      if (form.value.CourseID != null) {
        updateCourse(form.value).then(response => {
          proxy.$modal.msgSuccess("修改成功")
          open.value = false
          getList()
        })
      } else {
        addCourse(form.value).then(response => {
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
  const _CourseIDs = row.CourseID || ids.value
  proxy.$modal.confirm('是否确认删除课程管理编号为"' + _CourseIDs + '"的数据项？').then(function() {
    return delCourse(_CourseIDs)
  }).then(() => {
    getList()
    proxy.$modal.msgSuccess("删除成功")
  }).catch(() => {})
}

/** 导出按钮操作 */
function handleExport() {
  proxy.download('textbook/course/export', {
    ...queryParams.value
  }, `course_${new Date().getTime()}.xlsx`)
}

getList()
</script>
