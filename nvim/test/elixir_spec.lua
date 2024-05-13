local ex = require('elixir-tests')

local sample_output = [[
10:11:28.021 [debug] QUERY OK db=1.9ms decode=3.3ms queue=6.2ms
SELECT true FROM information_schema.tables WHERE table_name = $1 AND table_schema = current_schema() LIMIT 1 ["schema_migrations"]
Excluding tags: [:performance]


MDWeb.FacilityControllerTest [test/md_web/controllers/facility_controller_test.exs]
  * test index/2 success with filter on is deleted [L#106]  * test index/2 success with filter on is deleted (384.3ms) [L#106]

  1) test index/2 success with filter on is deleted (MDWeb.FacilityControllerTest)
     test/md_web/controllers/facility_controller_test.exs:106
     match (=) failed
     code:  assert %{"entries" => [%{"id" => 99}]} =
              conn
              |> add_auth_headers_with_permission("hospitalizations", :read)
              |> get(Routes.facility_path(conn, :index), %{is_deleted: true})
              |> json_response(200)
     left:  %{"entries" => [%{"id" => 99}]}
     right: %{
              "entries" => [
                %{
                  "owner" => nil,
                  "id" => 34,
                  "beds" => nil,
                  "address" => "62721 Stiedemann Shoals",
                  "deletedBy" => nil,
                  "isDeleted" => true
                }
              ],
              "pageNumber" => 1,
              "pageSize" => 100,
              "totalEntries" => 1,
              "totalPages" => 1
            }
     stacktrace:
       test/md_web/controllers/facility_controller_test.exs:109: (test)

  * test update [L#133]  * test update (26.1ms) [L#133]
  * test delete [L#156]  * test delete (16.0ms) [L#156]
  * test update add phone [L#144]  * test update add phone (22.4ms) [L#144]
  * test index/2 success with search on address [L#54]  * test index/2 success with search on address (22.0ms) [L#54]
  * test index/2 success with search on name [L#38]  * test index/2 success with search on name (19.8ms) [L#38]
  * test index/2 success with filter on state [L#90]  * test index/2 success with filter on state (19.5ms) [L#90]
  * test get [L#123]  * test get (13.3ms) [L#123]
  * test create/2 success [L#12]  * test create/2 success (15.0ms) [L#12]

  2) test create/2 success (MDWeb.FacilityControllerTest)
     test/md_web/controllers/facility_controller_test.exs:12
     match (=) failed
     The following variables were pinned:
       type = "ltc"
       number = "19199293949"
       name = "facility_name"
     code:  assert %{name: ^name, type: ^type, phones: [%{number: ^number}]} =
              Repo.get(Facility, 99) |> Repo.preload(:phones)
     left:  %{name: ^name, type: ^type, phones: [%{number: ^number}]}
     right: nil
     stacktrace:
       test/md_web/controllers/facility_controller_test.exs:29: (test)

  * test index/2 success with search on phone [L#70]  * test index/2 success with search on phone (24.3ms) [L#70]


Finished in 0.7 seconds (0.7s async, 0.00s sync)
10 tests, 2 failures

Randomized with seed 910994
]]

local sample_data = {}

for line in sample_output:gmatch('[^\n]+') do
  table.insert(sample_data, line)
end

local expected_parse_results = {
  preamble = {
    '10:11:28.021 [debug] QUERY OK db=1.9ms decode=3.3ms queue=6.2ms',
    'SELECT true FROM information_schema.tables WHERE table_name = $1 AND table_schema = current_schema() LIMIT 1 ["schema_migrations"]',
    'Excluding tags: [:performance]',
  },
  tests = {
    {
      module = 'MDWeb.FacilityControllerTest',
      file = 'test/md_web/controllers/facility_controller_test.exs',
      test = 'index/2 success with filter on is deleted',
      time = '384.3ms',
      line = 106,
      success = true,
      output = {},
    },
  },
  summary = {
    'Finished in 0.7 seconds (0.7s async, 0.00s sync)',
    '10 tests, 2 failures',
    'Randomized with seed 910994',
  },
}

describe('parsing tests', function()
  local results = ex.parse_tests(sample_data)

  print(vim.inspect(results))

  it('should match expected', function()
    assert.equals(vim.tbl_count(results.premble), vim.tbl_count(expected_parse_results.premble))

    for i in ipairs(results.preamble) do
      assert.equals(results.preamble[i], expected_parse_results.preamble[i])
    end

    print(vim.inspect({ results = vim.tbl_count(results.tests), parsed = vim.tbl_count(expected_parse_results.tests) }))
    assert.equals(vim.tbl_count(results.tests), vim.tbl_count(expected_parse_results.tests))

    for i in ipairs(results.tests) do
      cur_test = results.tests[i]
      expected_test = expected_parse_results.tests[i]

      assert.equals(cur_test.module, expected_test.module)
      assert.equals(cur_test.file, expected_test.file)
      assert.equals(cur_test.test, expected_test.test)
      assert.equals(cur_test.time, expected_test.time)
      assert.equals(cur_test.line, expected_test.line)
      assert.equals(cur_test.success, expected_test.success)

      assert.equals(vim.tbl_count(cur_test.output), vim.tbl_count(expected_test.output))

      for i in ipairs(cur_test.output) do
        assert.equals(cur_test.output[i], expected_test.output[i])
      end
    end

    assert.equals(vim.tbl_count(results.summary), vim.tbl_count(expected_parse_results.summary))

    for i in ipairs(results.summary) do
      assert.equals(results.summary[i], expected_parse_results.summary[i])
    end
  end)
end)
