<template>
  <div class="app-container">
    <el-form :model="queryParams" ref="queryRef" :inline="true" v-show="showSearch" label-width="68px">
      <el-form-item label="学期" prop="semester">
        <el-input
          v-model="queryParams.semester"
          placeholder="请输入学期"
          clearable
          @keyup.enter="handleQuery"
        />
      </el-form-item>
      <el-form-item label="课程id" prop="courseid">
        <el-input
          v-model="queryParams.courseid"
          placeholder="请输入课程id"
          clearable
          @keyup.enter="handleQuery"
        />
      </el-form-item>
      <el-form-item label="班级id" prop="classid">
        <el-input
          v-model="queryParams.classid"
          placeholder="请输入班级id"
          clearable
          @keyup.enter="handleQuery"
        />
      </el-form-item>
      <el-form-item label="教师id" prop="teacherid">
        <el-input
          v-model="queryParams.teacherid"
          placeholder="请输入教师id"
          clearable
          @keyup.enter="handleQuery"
        />
      </el-form-item>
      <el-form-item label="学生数量" prop="studentcount">
        <el-input
          v-model="queryParams.studentcount"
          placeholder="请输入学生数量"
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
          v-hasPermi="['textbook:teachingplan:add']"
        >新增</el-button>
      </el-col>
      <el-col :span="1.5">
        <el-button
          type="success"
          plain
          icon="Edit"
          :disabled="single"
          @click="handleUpdate"
          v-hasPermi="['textbook:teachingplan:edit']"
        >修改</el-button>
      </el-col>
      <el-col :span="1.5">
        <el-button
          type="danger"
          plain
          icon="Delete"
          :disabled="multiple"
          @click="handleDelete"
          v-hasPermi="['textbook:teachingplan:remove']"
        >删除</el-button>
      </el-col>
      <el-col :span="1.5">
        <el-button
          type="warning"
          plain
          icon="Download"
          @click="handleExport"
          v-hasPermi="['textbook:teachingplan:export']"
        >导出</el-button>
      </el-col>
      <right-toolbar v-model:showSearch="showSearch" @queryTable="getList"></right-toolbar>
    </el-row>

    <el-table v-loading="loading" :data="teachingplanList" @selection-change="handleSelectionChange">
      <el-table-column type="selection" width="55" align="center" />
      <el-table-column label="计划id" align="center" prop="planid" />
      <el-table-column label="学期" align="center" prop="semester" />
      <el-table-column label="课程id" align="center" prop="courseid" />
      <el-table-column label="班级id" align="center" prop="classid" />
      <el-table-column label="教师id" align="center" prop="teacherid" />
      <el-table-column label="学生数量" align="center" prop="studentcount" />
      <el-table-column label="操作" align="center" class-name="small-padding fixed-width">
        <template #default="scope">
          <el-button link type="primary" icon="Edit" @click="handleUpdate(scope.row)" v-hasPermi="['textbook:teachingplan:edit']">修改</el-button>
          <el-button link type="primary" icon="Delete" @click="handleDelete(scope.row)" v-hasPermi="['textbook:teachingplan:remove']">删除</el-button>
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

    <!-- 添加或修改教学计划对话框 -->
    <el-dialog :title="title" v-model="open" width="500px" append-to-body>
      <el-form ref="teachingplanRef" :model="form" :rules="rules" label-width="80px">
        <el-form-item label="学期" prop="semester">
          <el-input v-model="form.semester" placeholder="请输入学期" />
        </el-form-item>
        <el-form-item label="课程id" prop="courseid">
          <el-input v-model="form.courseid" placeholder="请输入课程id" />
        </el-form-item>
        <el-form-item label="班级id" prop="classid">
          <el-input v-model="form.classid" placeholder="请输入班级id" />
        </el-form-item>
        <el-form-item label="教师id" prop="teacherid">
          <el-input v-model="form.teacherid" placeholder="请输入教师id" />
        </el-form-item>
        <el-form-item label="学生数量" prop="studentcount">
          <el-input v-model="form.studentcount" placeholder="请输入学生数量" />
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

<script setup name="Teachingplan">
import { listTeachingplan, getTeachingplan, delTeachingplan, addTeachingplan, updateTeachingplan } from "@/api/textbook/teachingplan"

const { proxy } = getCurrentInstance()

const teachingplanList = ref([])
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
    semester: null,
    courseid: null,
    classid: null,
    teacherid: null,
    studentcount: null
  },
  rules: {
  }
})

const { queryParams, form, rules } = toRefs(data)

/** 查询教学计划列表 */
function getList() {
  loading.value = true
  listTeachingplan(queryParams.value).then(response => {
    teachingplanList.value = response.rows
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
    planid: null,
    semester: null,
    courseid: null,
    classid: null,
    teacherid: null,
    studentcount: null
  }
  proxy.resetForm("teachingplanRef")
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
  ids.value = selection.map(item => item.planid)
  single.value = selection.length != 1
  multiple.value = !selection.length
}

/** 新增按钮操作 */
function handleAdd() {
  reset()
  open.value = true
  title.value = "添加教学计划"
}

/** 修改按钮操作 */
function handleUpdate(row) {
  reset()
  const _planid = row.planid || ids.value
  getTeachingplan(_planid).then(response => {
    form.value = response.data
    open.value = true
    title.value = "修改教学计划"
  })
}

/** 提交按钮 */
function submitForm() {
  proxy.$refs["teachingplanRef"].validate(valid => {
    if (valid) {
      if (form.value.planid != null) {
        updateTeachingplan(form.value).then(response => {
          proxy.$modal.msgSuccess("修改成功")
          open.value = false
          getList()
        })
      } else {
        addTeachingplan(form.value).then(response => {
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
  const _planids = row.planid || ids.value
  proxy.$modal.confirm('是否确认删除教学计划编号为"' + _planids + '"的数据项？').then(function() {
    return delTeachingplan(_planids)
  }).then(() => {
    getList()
    proxy.$modal.msgSuccess("删除成功")
  }).catch(() => {})
}

/** 导出按钮操作 */
function handleExport() {
  proxy.download('textbook/teachingplan/export', {
    ...queryParams.value
  }, `teachingplan_${new Date().getTime()}.xlsx`)
}

getList()
</script>
