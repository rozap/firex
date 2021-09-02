# NOTE: This class is auto generated by OpenAPI Generator (https://openapi-generator.tech).
# https://openapi-generator.tech
# Do not edit the class manually.

defmodule Firex.FirecrackerAPI.RequestBuilder do
  @moduledoc """
  Helper functions for building Tesla requests
  """

  @doc """
  Specify the request method when building a request

  ## Parameters

  - request (Map) - Collected request options
  - m (atom) - Request method

  ## Returns

  Map
  """
  @spec method(map(), atom) :: map()
  def method(request, m) do
    Map.put_new(request, :method, m)
  end

  @doc """
  Specify the request method when building a request

  ## Parameters

  - request (Map) - Collected request options
  - u (String) - Request URL

  ## Returns

  Map
  """
  @spec url(map(), String.t()) :: map()
  def url(request, u) do
    Map.put_new(request, :url, u)
  end

  @doc """
  Add optional parameters to the request

  ## Parameters

  - request (Map) - Collected request options
  - definitions (Map) - Map of parameter name to parameter location.
  - options (KeywordList) - The provided optional parameters

  ## Returns

  Map
  """
  @spec add_optional_params(map(), %{optional(atom) => atom}, keyword()) :: map()
  def add_optional_params(request, _, []), do: request

  def add_optional_params(request, definitions, [{key, value} | tail]) do
    case definitions do
      %{^key => location} ->
        request
        |> add_param(location, key, value)
        |> add_optional_params(definitions, tail)

      _ ->
        add_optional_params(request, definitions, tail)
    end
  end

  @doc """
  Add optional parameters to the request

  ## Parameters

  - request (Map) - Collected request options
  - location (atom) - Where to put the parameter
  - key (atom) - The name of the parameter
  - value (any) - The value of the parameter

  ## Returns

  Map
  """
  @spec add_param(map(), atom, atom, any()) :: map()
  def add_param(request, :body, :body, value), do: Map.put(request, :body, value)

  def add_param(request, :body, key, value) do
    request
    |> Map.put_new_lazy(:body, &Tesla.Multipart.new/0)
    |> Map.update!(
      :body,
      &Tesla.Multipart.add_field(&1, key, Poison.encode!(value),
        headers: [{:"Content-Type", "application/json"}]
      )
    )
  end

  def add_param(request, :headers, key, value) do
    request
    |> Tesla.put_header(key, value)
  end

  def add_param(request, :file, name, path) do
    request
    |> Map.put_new_lazy(:body, &Tesla.Multipart.new/0)
    |> Map.update!(:body, &Tesla.Multipart.add_file(&1, path, name: name))
  end

  def add_param(request, :form, name, value) do
    request
    |> Map.update(:body, %{name => value}, &Map.put(&1, name, value))
  end

  def add_param(request, location, key, value) do
    Map.update(request, location, [{key, value}], &(&1 ++ [{key, value}]))
  end

  @doc """
  Due to a bug in httpc, POST, PATCH and PUT requests will fail, if the body is empty

  This function will ensure, that the body param is always set

  ## Parameters

  - request (Map) - Collected request options

  ## Returns

  Map
  """
  @spec ensure_body(map()) :: map()
  def ensure_body(%{body: nil} = request) do
    %{request | body: ""}
  end

  def ensure_body(request) do
    Map.put_new(request, :body, "")
  end

  @doc """
  Handle the response for a Tesla request

  ## Parameters

  - arg1 (Tesla.Env.t | term) - The response object
  - arg2 (:false | struct | [struct]) - The shape of the struct to deserialize into

  ## Returns

  {:ok, struct} on success
  {:error, term} on failure
  """
  @spec decode(Tesla.Env.t() | term(), false | struct() | [struct()]) ::
          {:ok, struct()} | {:ok, Tesla.Env.t()} | {:error, any}
  def decode(%Tesla.Env{} = env, false), do: {:ok, env}
  def decode(%Tesla.Env{body: body}, struct), do: Poison.decode(body, as: struct)

  def evaluate_response({:ok, %Tesla.Env{} = env}, mapping) do
    resolve_mapping(env, mapping)
  end

  def evaluate_response({:error, _} = error, _), do: error

  def resolve_mapping(env, mapping, default \\ nil)

  def resolve_mapping(%Tesla.Env{status: status} = env, [{mapping_status, struct} | _], _)
      when status == mapping_status do
    decode(env, struct)
  end

  def resolve_mapping(env, [{:default, struct} | tail], _), do: resolve_mapping(env, tail, struct)
  def resolve_mapping(env, [_ | tail], struct), do: resolve_mapping(env, tail, struct)
  def resolve_mapping(env, [], nil), do: {:error, env}
  def resolve_mapping(env, [], struct), do: decode(env, struct)
end