"""Top-level package for napari-bioio."""

from importlib.metadata import PackageNotFoundError, version

try:
    __version__ = version("napari-bioio")
except PackageNotFoundError:
    __version__ = "uninstalled"

__author__ = "Eva Maxfield Brown"
__email__ = "evamaxfieldbrown@gmail.com"


def get_module_version() -> str:
    return __version__
